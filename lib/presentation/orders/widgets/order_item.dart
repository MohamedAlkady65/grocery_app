import 'package:flutter/material.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/data/models/order_model.dart';
import 'package:grocery_app/presentation/orders/widgets/order_item_body.dart';
import 'package:grocery_app/presentation/orders/widgets/order_item_header.dart';

class OrderItem {
  ExpansionPanel call({required bool isExpanded, required OrderModel order}) {
    return ExpansionPanel(
        backgroundColor: MyColors.backgroundPrimary,
        isExpanded: isExpanded,
        headerBuilder: (context, isExpanded) => OrderItemHeader(
              order: order,
            ),
        body: OrderItemBody(
          steps: order.steps,
        ));
  }
}
