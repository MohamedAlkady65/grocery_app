import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/generated/l10n.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    super.key,
    this.onTap,
  });
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: SvgPicture.asset("assets/images/cart_icon.svg", width: 20),
          ),
          Text(
            S.of(context).addToCart,
            style: TextStyle(
                fontWeight: MyFontWeights.medium,
                fontSize: 14,
                color: MyColors.text),
          ),
          const SizedBox()
        ],
      ),
    );
  }
}
