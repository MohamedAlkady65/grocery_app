import 'package:flutter/widgets.dart';
import 'package:grocery_app/constants/style.dart';

class OrderOneInfo extends StatelessWidget {
  const OrderOneInfo({
    super.key,
    required this.title,
    required this.value,
    this.valueFontSize = 16,
  });

  final String title;
  final String value;
  final double valueFontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 16,
              color: MyColors.text,
              fontWeight: MyFontWeights.medium),
        ),
        Text(value,
            textAlign: TextAlign.end,
            style: TextStyle(
                fontSize: valueFontSize,
                color: MyColors.primaryDark,
                fontWeight: MyFontWeights.regular)),
      ],
    );
  }
}
