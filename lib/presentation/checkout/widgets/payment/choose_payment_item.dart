import 'package:flutter/material.dart';
import 'package:grocery_app/constants/enums.dart';
import 'package:grocery_app/constants/style.dart';

class PaymentMethodItem extends StatelessWidget {
  const PaymentMethodItem(
      {super.key,
      required this.icon,
      required this.text,
      required this.value,
      required this.groupValue,
      this.onChanged});
  final IconData icon;
  final String text;
  final PaymentMethod value;
  final PaymentMethod? groupValue;
  final void Function(PaymentMethod? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: MyColors.backgroundPrimary,
      child: RadioListTile<PaymentMethod>(
        tileColor: MyColors.backgroundPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        activeColor: MyColors.primaryDark,
        fillColor: MaterialStateColor.resolveWith((states) =>
            states.contains(MaterialState.selected)
                ? MyColors.primaryDark
                : MyColors.textSecondry),
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        title: Row(children: [
          Icon(
            icon,
            color: color(),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            text,
            style: TextStyle(
                color: color(), fontWeight: MyFontWeights.medium, fontSize: 18),
          )
        ]),
      ),
    );
  }

  Color color() {
    return groupValue == value ? MyColors.primaryDark : MyColors.textSecondry;
  }
}
