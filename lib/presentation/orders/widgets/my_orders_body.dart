import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/data/models/order_model.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:grocery_app/logic/orders_cubit/orders_cubit.dart';
import 'package:grocery_app/presentation/orders/widgets/empty_orders_body.dart';
import 'package:grocery_app/presentation/orders/widgets/my_orders_loading.dart';
import 'package:grocery_app/presentation/orders/widgets/orders_list.dart';

class MyOrdersBody extends StatelessWidget {
  const MyOrdersBody({super.key});
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<OrdersCubit>(context).getOrders(context);
    return BlocConsumer<OrdersCubit, OrdersState>(
      listener: (context, state) {
        if(state is OrdersFailure)
        {
              showErrorSnackBar(context);

        }
      },
      buildWhen: (previous, current) => current is MyOrdersState,
      builder: (context, state) {
        if (state is OrdersSuccess) {
          List<OrderModel> orders =
              BlocProvider.of<OrdersCubit>(context).orders;

          if (orders.isEmpty) {
            return const EmptyOrders();
          } else {
            return OrdersList(
              orders: orders,
            );
          }
        } else if (state is OrdersLoading) {
          return const MyOrdersLoading();
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
