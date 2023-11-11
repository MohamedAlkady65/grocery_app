import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/presentation/cart/cart_screen.dart';

class CartFloatingActionButton extends StatelessWidget {
  const CartFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        Navigator.pushNamed(context, CartScreen.id);
      },
      backgroundColor: MyColors.primaryDark,
      child: SvgPicture.asset(
        "assets/images/cart_icon_white.svg",
        width: 25,
        color: MyColors.backgroundPrimary,
      ),
    );
  }
}
