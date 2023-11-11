import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/data/models/order_model.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:grocery_app/logic/orders_cubit/orders_cubit.dart';
import 'package:grocery_app/presentation/components/order_details_section.dart';
import 'package:grocery_app/presentation/order_details/widgets/order_details_loading.dart';
import 'package:grocery_app/presentation/order_details/widgets/order_items_list.dart';

class OrderDetailsBody extends StatelessWidget {
  const OrderDetailsBody({super.key, required this.order});
  final OrderModel order;
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<OrdersCubit>(context)
        .getOrderItems(orderId: order.id, context: context);
    return BlocConsumer<OrdersCubit, OrdersState>(
      listener: (context, state) {
        if (state is OrderItemsFailure) {
          showErrorSnackBar(context);
        }
      },
      buildWhen: (previous, current) => current is OrderItemsState,
      builder: (context, state) {
        if (state is OrderItemsLoading) {
          return const OrderDetailsLoading();
        } else if (state is OrderItemsSuccess) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).orderDetails,
                    style: TextStyle(
                        fontSize: 22,
                        color: MyColors.text,
                        fontWeight: MyFontWeights.semiBold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  OrderDetailsSection(order: order),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    S.of(context).orderItems,
                    style: TextStyle(
                        fontSize: 22,
                        color: MyColors.text,
                        fontWeight: MyFontWeights.semiBold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  OrderItemsList(
                    orderItems: state.orderItems,
                  )
                ],
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
