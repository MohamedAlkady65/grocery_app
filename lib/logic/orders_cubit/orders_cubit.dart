import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/constants/enums.dart';
import 'package:grocery_app/data/models/order_item_model.dart';
import 'package:grocery_app/data/models/order_model.dart';
import 'package:grocery_app/data/services/orders_services.dart';
import 'package:meta/meta.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());
  OrdersServices ordersServices = OrdersServices();
  List<OrderModel> orders = [];
  void getOrders(BuildContext context) async {
    emit(OrdersLoading());

    final response = await ordersServices.getOrders();

    if (response.state == DataResponse.success) {
      orders = response.orders;
      emit(OrdersSuccess());
    } else {
        emit(OrdersFailure());
    }
  }

  void getOrderItems(
      {required BuildContext context, required String orderId}) async {
    emit(OrderItemsLoading());
    final response = await ordersServices.getOrderItems(orderId);

    if (response.state == DataResponse.success) {
      emit(OrderItemsSuccess(response.orderItems));
    } else {
        emit(OrderItemsFailure());
    }
  }
  @override
  void emit(OrdersState state) {
        if (!isClosed) {
      super.emit(state);
    }
  }
}
