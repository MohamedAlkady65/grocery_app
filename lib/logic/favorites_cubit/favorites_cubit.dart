import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/constants/enums.dart';
import 'package:grocery_app/data/models/product_model.dart';
import 'package:grocery_app/data/services/favorites_services.dart';
import 'package:grocery_app/logic/products_cubit/products_cubit.dart';
import 'package:meta/meta.dart';
part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit(this.productsCubit) : super(FavoritesInitial());
  final ProductsCubit productsCubit;
  FavoritesServices favoritesServices = FavoritesServices();

  List<ProductModel> favoritesProducts = [];

  Future<void> getFavoritesProducts() async {
    emit(FavoriteProductsLoading());

    await skipFavoriteProductsChanging();

    final response = await favoritesServices.getFavoritesProducts();

    if (response.state == DataResponse.success) {
      favoritesProducts = response.data;
      emit(FavoriteProductsSuccess());
    } else {
      emit(FavoriteProductsFailure());
    }
  }

  Future<void> skipFavoriteProductsChanging() async {
    await Future.wait(productsCubit.favoritesDebouncers.map((e) => e.skip()));
  }

  Future<void> deleteFavoriteProduct({
    required String productId,
  }) async {
    final index =
        favoritesProducts.indexWhere((element) => element.id == productId);

    final product = favoritesProducts[index];

    favoritesProducts.removeAt(index);

    emit(FavoriteProductsSuccess());

    final response = await removeFavorite(
        productId: productId, productsCubit: productsCubit);

    if (response == DataResponse.failure) {
      favoritesProducts.insert(index, product);
      emit(FavoriteProductsSuccess());
    }
  }

  Future<DataResponse> removeFavorite({
    required String productId,
    required ProductsCubit productsCubit,
  }) async {
    if (FirebaseAuth.instance.currentUser == null) return DataResponse.failure;
    productsCubit.changeFavoriteProductInUI(
        productId: productId, isFavorite: false);

    final response = await favoritesServices.changeFavorite(
        productId: productId, newState: false);

    if (response == DataResponse.failure) {
      productsCubit.changeFavoriteProductInUI(
          productId: productId, isFavorite: true);
    }

    return response;
  }

  Future<void> deleteFavoriteInUI({
    required String productId,
  }) async {
    favoritesProducts.removeWhere((element) => element.id == productId);

    emit(FavoriteProductsSuccess());
  }

  Future<void> clearFavorites() async {
    if (FirebaseAuth.instance.currentUser == null) return;

    final response = await favoritesServices.clearfavorites(favoritesProducts);

    if (response == DataResponse.success) {
      productsCubit.clearFavorites();
      favoritesProducts.clear();
      emit(FavoriteProductsSuccess());
    } else {
      emit(FavoriteProductsFailure());
    }
  }

  @override
  void emit(FavoritesState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
