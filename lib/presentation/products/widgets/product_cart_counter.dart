import 'package:flutter/material.dart';
import 'package:grocery_app/presentation/cart/widgets/cart_button.dart';
import 'package:grocery_app/constants/style.dart';

class ProductCartCounter extends StatelessWidget {
  const ProductCartCounter({
    super.key,
    required this.counter,
    this.decreaseOnTap,
    this.increaseOnTap,
  });
  final int counter;
  final void Function()? decreaseOnTap;
  final void Function()? increaseOnTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CartButton(icon: 0, onTap: decreaseOnTap),
        Text(
          "$counter",
          style: TextStyle(
              fontWeight: MyFontWeights.medium,
              fontSize: 16,
              color: MyColors.text),
        ),
        CartButton(icon: 1, onTap: increaseOnTap),
      ],
    );
  }
}
