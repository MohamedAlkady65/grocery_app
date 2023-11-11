part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoadItemsState extends CartState {}

final class CartItemsSuccess extends CartLoadItemsState {}

final class CartItemsLoading extends CartLoadItemsState {}

final class CartItemsFailure extends CartLoadItemsState {

}

final class CartItemsChangingTotalPrice extends CartState {}
