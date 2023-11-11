import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {super.key, this.onPressed, required this.color, required this.child});

  final Widget child;
  final void Function()? onPressed;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(color.withOpacity(0.1)),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
