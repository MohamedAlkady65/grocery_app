import 'package:flutter/material.dart';
import 'package:grocery_app/constants/style.dart';

class HomeSection extends StatelessWidget {
  const HomeSection(
      {super.key,
      required this.title,
      this.onPressed,
      required this.child,
      required this.color,
      required this.padding});
  final String title;
  final void Function()? onPressed;
  final Widget child;
  final Color color;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: MyFontWeights.semiBold,
                      color: MyColors.text),
                ),
                SizedBox(
                  width: 22,
                  height: 22,
                  child: IconButton(
                    splashRadius: 20,
                    padding: EdgeInsets.zero,
                    onPressed: onPressed,
                    icon: const Icon(Icons.arrow_forward_ios_rounded),
                    color: MyColors.textSecondry,
                  ),
                )
              ],
            ),
          ),
          child
        ],
      ),
    );
  }
}
