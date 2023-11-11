import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/data/models/order_model.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/helper/date_helper.dart';
import 'package:grocery_app/logic/orders_cubit/orders_cubit.dart';
import 'package:grocery_app/presentation/order_details/order_details_screen.dart';

class OrderItemHeader extends StatelessWidget {
  const OrderItemHeader({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, OrderDetailsScreen.id, arguments: (
          cubit: BlocProvider.of<OrdersCubit>(context),
          order: order
        ));
      },
      tileColor: MyColors.backgroundPrimary,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      horizontalTitleGap: 12,
      isThreeLine: true,
      title: Text(
        "Order #${order.id}",
        style: TextStyle(
            fontWeight: MyFontWeights.semiBold,
            fontSize: 15,
            color: MyColors.text),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 2,
          ),
          Text(
            "Placed on \n${DateHelper.getDate(date: order.steps[0]!, context: context).toString()}",
            style: TextStyle(
                fontWeight: MyFontWeights.medium,
                fontSize: 12,
                color: MyColors.textSecondry),
          ),
          const SizedBox(
            height: 3,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: S.of(context).itemsWithColon,
                style: TextStyle(
                    fontWeight: MyFontWeights.regular,
                    fontSize: 14,
                    color: MyColors.text)),
            TextSpan(
                text: order.itemsCount.toString(),
                style: TextStyle(
                    fontWeight: MyFontWeights.semiBold,
                    fontSize: 14,
                    color: MyColors.text)),
          ])),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: S.of(context).totalPriceWithColon,
                style: TextStyle(
                    fontWeight: MyFontWeights.regular,
                    fontSize: 14,
                    color: MyColors.text)),
            TextSpan(
                text: order.totalPrice.toStringAsFixed(2),
                style: TextStyle(
                    fontWeight: MyFontWeights.semiBold,
                    fontSize: 14,
                    color: MyColors.text)),
          ])),
        ],
      ),
      leading: SvgPicture.asset("assets/images/orders/order.svg"),
    );
  }
}
