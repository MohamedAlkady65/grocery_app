import 'package:flutter/material.dart';
import 'package:grocery_app/presentation/cart/widgets/cart_button.dart';
import 'package:grocery_app/constants/style.dart';

class CounterCartItem extends StatelessWidget {
  const CounterCartItem(
      {super.key, required this.count, this.decreaseOnTap, this.increaseOnTap});

  final int count;
  final void Function()? decreaseOnTap;
  final void Function()? increaseOnTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CartButton(icon: 1, onTap: increaseOnTap),
          Text(
            "$count",
            style: TextStyle(
                fontWeight: MyFontWeights.medium,
                fontSize: 16,
                color: MyColors.text),
          ),
          CartButton(icon: 0, onTap: decreaseOnTap),
        ],
      ),
    );
  }
}
