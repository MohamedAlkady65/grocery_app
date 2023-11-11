import 'package:flutter/material.dart';
import 'package:grocery_app/constants/style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.onTap, this.icon, required this.text});

  final void Function()? onTap;
  final Widget? icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 36),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: MyColors.backgroundPrimary),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            icon ?? const SizedBox(),
            Text(
              text,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: MyFontWeights.medium,
                  color: MyColors.text),
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
