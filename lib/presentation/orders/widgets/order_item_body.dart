import 'package:flutter/material.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/helper/date_helper.dart';
import 'package:grocery_app/presentation/orders/widgets/dotted_line.dart';
import 'package:grocery_app/presentation/orders/widgets/step_info.dart';
import 'package:grocery_app/constants/style.dart';

class OrderItemBody extends StatelessWidget {
  const OrderItemBody({super.key, required this.steps});

  final List<DateTime?> steps;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 22, right: 22, bottom: 22, top: 10),
      color: MyColors.backgroundPrimary,
      height: 220,
      child: Row(
        children: [
          DottedLine(
            number: steps.length,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StepInfo(
                    color: MyColors.text,
                    title: S.of(context).orderPlaced,
                    date: DateHelper.getDate(date: steps[0]!, context: context)
                        .toString()),
                StepInfo(
                    color: MyColors.text,
                    title: S.of(context).orderConfirmed,
                    date: steps.length > 1
                        ? DateHelper.getDate(date: steps[1]!, context: context)
                            .toString()
                        : S.of(context).pending),
                StepInfo(
                    color: MyColors.text,
                    title: S.of(context).orderShipped,
                    date: steps.length > 2
                        ? DateHelper.getDate(date: steps[2]!, context: context)
                            .toString()
                        : S.of(context).pending),
                StepInfo(
                    color: MyColors.text,
                    title: S.of(context).outForDelivery,
                    date: steps.length > 3
                        ? DateHelper.getDate(date: steps[3]!, context: context)
                            .toString()
                        : S.of(context).pending),
                StepInfo(
                    color: MyColors.text,
                    title: S.of(context).orderDelivered,
                    date: steps.length > 4
                        ? DateHelper.getDate(date: steps[4]!, context: context)
                            .toString()
                        : S.of(context).pending),
              ],
            ),
          )
        ],
      ),
    );
  }
}
