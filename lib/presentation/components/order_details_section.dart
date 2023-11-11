import 'package:flutter/material.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/data/models/order_model.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/helper/date_helper.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:grocery_app/presentation/components/order_one_info.dart';

class OrderDetailsSection extends StatelessWidget {
  const OrderDetailsSection({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OrderOneInfo(
          title: S.of(context).orderId,
          value: "#${order.id}",
        ),
        divider(),
        OrderOneInfo(
          title: S.of(context).date,
          value: DateHelper.getDate(date: order.steps[0]!, context: context)
              .toString(),
        ),
        divider(),
        OrderOneInfo(
          title: S.of(context).totalPrice,
          value: stringPrice(order.totalPrice),
        ),
        divider(),
        OrderOneInfo(
          title: S.of(context).items,
          value: "${order.itemsCount}",
        ),
        divider(),
        OrderOneInfo(
          title: S.of(context).addressS,
          value:
              "${order.address.name}\n${order.address.street}, ${order.address.city}, ${order.address.country(context)}\n${order.address.zip}\n${order.address.phone.getPhoneText(context: context)}",
          valueFontSize: 14,
        ),
        divider(),
        OrderOneInfo(
          title: S.of(context).paymentMethod,
          value: order.paymentMethodString(context),
        ),
        if (order.transactionId != null) divider(),
        if (order.transactionId != null)
          OrderOneInfo(
            title: S.of(context).transactionId,
            value: "#${order.transactionId}",
          ),
      ],
    );
  }

  Divider divider() {
    return const Divider(
      thickness: 1,
      color: MyColors.grey,
    );
  }
}
