import 'package:flutter/material.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:intl/intl.dart';

class DottedLine extends StatelessWidget {
  const DottedLine({super.key, required this.number})
      : assert(number >= 1 && number <= 5);
  final int number;

  @override
  Widget build(BuildContext context) {
    List<Widget> fullLine = List<Widget>.generate(9, (index) {
      late Color color;

      if (index == 0 || index <= (number - 1) * 2) {
        color = MyColors.primaryDark;
      } else {
        color = MyColors.textSecondry;
      }

      if (index % 2 == 0) {
        return circle(color: color);
      } else {
        return line(color: color);
      }
    });

    return Padding(
      padding: Intl.getCurrentLocale() == "ar"
          ? const EdgeInsets.only(left: 16)
          : const EdgeInsets.only(right: 16),
      child: Column(
        children: fullLine,
      ),
    );
  }

  Widget line({required Color color}) {
    return Expanded(
        child: Container(
      width: 2,
      color: color,
    ));
  }

  Widget circle({required Color color}) {
    return Container(
      width: 12,
      height: 12,
      decoration: ShapeDecoration(
        shape: const CircleBorder(),
        color: color,
      ),
    );
  }
}
