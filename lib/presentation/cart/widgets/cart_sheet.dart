import 'package:flutter/material.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:grocery_app/presentation/components/bright_button.dart';
import 'package:grocery_app/constants/style.dart';

class CartSheet extends StatelessWidget {
  const CartSheet({super.key, required this.totalPrice, this.onTap});
  final double totalPrice;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: MyColors.backgroundPrimary, boxShadow: [
        BoxShadow(
          blurStyle: BlurStyle.normal,
          blurRadius: 10,
          color: MyColors.text.withOpacity(0.1),
          offset: const Offset(0, 1),
        )
      ]),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).totalPrice,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: MyFontWeights.semiBold,
                  color: MyColors.text),
            ),
            Text(
              stringPrice(totalPrice),
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: MyFontWeights.semiBold,
                  color: MyColors.text),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        BrightButton(
          text: S.of(context).checkout,
          onTap: onTap,
        )
      ]),
    );
  }
}
