import 'package:flutter/material.dart';
import 'package:grocery_app/constants/style.dart';

class CounterAddtoCartProductDetails extends StatelessWidget {
  const CounterAddtoCartProductDetails({
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
    return Container(
      height: 60,
      color: MyColors.backgroundPrimary,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        SizedBox(
          width: 60,
          height: 60,
          child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: decreaseOnTap,
              icon: const Icon(
                Icons.indeterminate_check_box_sharp,
                size: 60,
                color: MyColors.primaryDark,
              )),
        ),
        Text(
          "$counter",
          style: TextStyle(
              fontSize: 20,
              fontWeight: MyFontWeights.semiBold,
              color: MyColors.text),
        ),
        SizedBox(
          width: 60,
          height: 60,
          child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: increaseOnTap,
              icon: const Icon(
                Icons.add_box_sharp,
                size: 60,
                color: MyColors.primaryDark,
              )),
        ),
      ]),
    );
  }
}
