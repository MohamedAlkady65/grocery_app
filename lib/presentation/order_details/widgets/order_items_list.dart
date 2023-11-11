import 'package:flutter/material.dart';
import 'package:grocery_app/data/models/order_item_model.dart';
import 'package:grocery_app/presentation/order_details/widgets/order_item.dart';

class OrderItemsList extends StatelessWidget {
  const OrderItemsList({super.key, required this.orderItems});
  final List<OrderItemModel> orderItems;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(
        height: 5,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: orderItems.length,
      itemBuilder: (context, index) => OrderItem(orderItem: orderItems[index]),
    );
  }
}
