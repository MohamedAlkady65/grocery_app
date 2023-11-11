
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartButton extends StatelessWidget {
  CartButton({super.key, this.onTap, required this.icon}) {
    if (icon != 1 && icon != 0) {
      throw Exception("Error");
    }
  }

  final void Function()? onTap;
  final int icon;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(99999),
      child: Material(
        type: MaterialType.circle,
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
              padding: const EdgeInsets.all(8),
              width: 32,
              height: 32,
              child: SvgPicture.asset(
                  "assets/images/${icon == 1 ? "plus" : "minus"}_icon.svg")),
        ),
      ),
    );
  }
}
