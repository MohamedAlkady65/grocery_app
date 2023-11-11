import 'package:flutter/material.dart';
import 'package:grocery_app/constants/style.dart';

class StepInfo extends StatelessWidget {
  const StepInfo(
      {super.key,
      required this.color,
      required this.title,
      required this.date});
  final Color color;
  final String title;
  final String date;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              height: 1,
              fontWeight: MyFontWeights.semiBold,
              fontSize: 12,
              color: color),
        ),
        Text(
          date,
          style: TextStyle(
              height: 1,
              fontWeight: MyFontWeights.regular,
              fontSize: 12,
              color: MyColors.textSecondry),
        ),
      ],
    );
  }
}
