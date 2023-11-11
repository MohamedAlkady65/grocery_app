part of 'orders_cubit.dart';

@immutable
sealed class OrdersState {}

final class OrdersInitial extends OrdersState {}

final class MyOrdersState extends OrdersState {}

final class OrderItemsState extends OrdersState {}

final class OrdersLoading extends MyOrdersState {}

final class OrdersSuccess extends MyOrdersState {}

final class OrdersFailure extends MyOrdersState {

}

final class OrderItemsLoading extends OrderItemsState {}

final class OrderItemsSuccess extends OrderItemsState {
  final List<OrderItemModel> orderItems;

  OrderItemsSuccess(this.orderItems);
}

final class OrderItemsFailure extends OrderItemsState {

}
