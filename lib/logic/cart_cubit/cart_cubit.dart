import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/constants/enums.dart';
import 'package:grocery_app/data/models/cart_item_model.dart';
import 'package:grocery_app/data/services/cart_services.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:grocery_app/logic/products_cubit/products_cubit.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this.productsCubit) : super(CartInitial());

  final ProductsCubit productsCubit;

  CartServices cartServices = CartServices();

  List<CartItemModel> cartItems = [];
  double totalPrice = 0;
  Future<void> getCartItems() async {
    emit(CartItemsLoading());
    await skipCartProductsChanging();
    final response = await cartServices.getCartItems();
    if (response.state == DataResponse.success) {
      cartItems = response.data;
      changingTotalPrice();
      emit(CartItemsSuccess());
    } else {
      emit(CartItemsFailure());
    }
  }

  Future<void> skipCartProductsChanging() async {
    await Future.wait(productsCubit.cartDebouncers.map((e) => e.skip()));
  }

  void changingTotalPrice() {
    totalPrice = roundSafty(cartItems.fold(
        0.0, (sum, item) => sum + roundSafty(item.product.price * item.count)));

    emit(CartItemsChangingTotalPrice());
  }

  Future<void> changeCartItemCount(
      {required String productId,
      required int newValue,
      required Function() onError,
      required int value}) async {
    if (FirebaseAuth.instance.currentUser == null) return;

    final response = await cartServices.changeCartItemCount(
        productId: productId,
        newValue: newValue,
        isNew: (newValue - value == 0));

    if (response == DataResponse.failure) {
      onError();
      changingTotalPrice();
      productsCubit.changeCartItemCountInUI(
          productId: productId, count: newValue - value);
    }
  }

  Future<void> deleteCartItem({required String productId}) async {
    final index =
        cartItems.indexWhere((element) => element.product.id == productId);
    final item = cartItems[index];
    cartItems.removeAt(index);

    changingTotalPrice();
    emit(CartItemsSuccess());
    productsCubit.changeCartItemCountInUI(productId: productId, count: 0);

    final response = await cartServices.changeCartItemCount(
        productId: productId, newValue: 0, isNew: false);

    if (response == DataResponse.failure) {
      cartItems.insert(index, item);

      changingTotalPrice();
      emit(CartItemsSuccess());
      productsCubit.changeCartItemCountInUI(
          productId: productId, count: item.count);
    }
  }

  Future<void> deleteCartItemInUI({required String productId}) async {
    cartItems.removeWhere((element) => element.product.id == productId);
    emit(CartItemsSuccess());
  }

  Future<void> clearCartCheckout() async {
    if (FirebaseAuth.instance.currentUser == null) return;

    final response = await cartServices.clearCart(cartItems);

    if (response == DataResponse.success) {
      cartItems.clear();
      productsCubit.clearCart();
      emit(CartItemsSuccess());
    }
  }

  Future<void> clearCartButton() async {
    if (FirebaseAuth.instance.currentUser == null) return;

    final response = await cartServices.clearCart(cartItems);

    if (response == DataResponse.success) {
      cartItems.clear();
      productsCubit.clearCart();
      emit(CartItemsSuccess());
    } else {
      emit(CartItemsFailure());
    }
  }

  @override
  void emit(CartState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
