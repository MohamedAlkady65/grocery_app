import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/constants/enums.dart';
import 'package:grocery_app/data/models/cart_product_item_model.dart';
import 'package:grocery_app/data/models/product_model.dart';
import 'package:grocery_app/data/services/cart_services.dart';
import 'package:grocery_app/data/services/favorites_services.dart';
import 'package:grocery_app/data/services/products_services.dart';
import 'package:grocery_app/helper/debouncer.dart';
import 'package:meta/meta.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());
  ProductsServices productsServices = ProductsServices();
  CartServices cartServices = CartServices();
  FavoritesServices favoritesServices = FavoritesServices();

  List<ProductModel> featuredProducts = [];
  List<ProductModel> featuredProductsAtHome = [];
  List<ProductModel> productsOfCategory = [];

  List<Debouncer> favoritesDebouncers = [];
  Debouncer? favoritesDebouncerInProductDetails;
  List<Debouncer> cartDebouncers = [];
  Debouncer? cartDebouncerInProductDetails;
  int? oldCartValueInProductDetails;
  List<String> favoriteProducts = [];
  List<CartProductItemModel> cartItems = [];

  Future<void> getFeaturedProducts() async {
    emit(FeaturedProductsLoading());
    final response =
        await productsServices.getFeaturedProducts(productsCubit: this);
    if (response.state == DataResponse.success) {
      featuredProducts = response.data;
      emit(FeaturedProductsSuccess());
    } else {
        emit(FeaturedProductsFailure());
    }
  }

  Future<void> getFeaturedProductsAtHome() async {
    emit(FeaturedProductsAtHomeLoading());

    final response =
        await productsServices.getFeaturedAtHomeProducts(productsCubit: this);
        
    if (response.state == DataResponse.success) {
      featuredProductsAtHome = response.data;
      emit(FeaturedProductsAtHomeSuccess());
    } else {
        emit(FeaturedProductsAtHomeFailure());
    }
  }

  Future<void> getProductsOfCategory(
      {required String categoryId}) async {
    emit(CategoryProductsLoading());
    final response = await productsServices.getProductsOfCategory(
        categoryId: categoryId,productsCubit: this);
    if (response.state == DataResponse.success) {
      productsOfCategory = response.data;
      emit(CategoryProductsSuccess());
    } else {
        emit(CategoryProductsFailure());
    }
  }

  Future<DataResponse> changeCartItemCount(
      {required String productId,
      required int newValue,
      required int oldValue}) async {
    if (FirebaseAuth.instance.currentUser == null) return DataResponse.failure;

    final response = await cartServices.changeCartItemCount(
        productId: productId, newValue: newValue, isNew: oldValue == 0);

    if (response == DataResponse.failure) {
      changeCartItemCountInUI(productId: productId, count: oldValue);
    }

    return response;
  }

  Future<DataResponse> changeFavorite(
      {required String productId, required bool newState}) async {
    if (FirebaseAuth.instance.currentUser == null) return DataResponse.failure;

    final response = await favoritesServices.changeFavorite(
        productId: productId, newState: newState);

    if (response == DataResponse.failure) {
      changeFavoriteProductInUI(productId: productId, isFavorite: !newState);
    }

    return response;
  }

  void changeCartItemCountInUI(
      {required String productId, required int count}) {
    if (count == 0) {
      cartItems.removeWhere((element) => element.productId == productId);
    } else {
      final item = cartItems
          .firstWhereOrNull((element) => element.productId == productId);

      if (item == null) {
        cartItems.add(CartProductItemModel(productId: productId, count: count));
      } else {
        item.count = count;
      }
    }

    emit(ChangingProductState(productId));
  }

  void changeFavoriteProductInUI(
      {required String productId, required bool isFavorite}) {
    if (isFavorite) {
      favoriteProducts.add(productId);
    } else {
      favoriteProducts.remove(productId);
    }

    emit(ChangingProductState(productId));
  }

  void clearFavorites() {
    List<String> temp = List<String>.from(favoriteProducts, growable: false);
    favoriteProducts.clear();
    for (var fav in temp) {
      emit(ChangingProductState(fav));
    }
  }

  void clearCart() {
    List<CartProductItemModel> temp =
        List<CartProductItemModel>.from(cartItems, growable: false);
    cartItems.clear();
    for (var item in temp) {
      emit(ChangingProductState(item.productId));
    }
  }

  @override
  void emit(ProductsState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
