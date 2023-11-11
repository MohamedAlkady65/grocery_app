import 'package:flutter/material.dart';

class IconButtonAppBarAction extends StatelessWidget {
  const IconButtonAppBarAction({super.key, required this.icon, this.onPressed});

  final Icon icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8,left: 8),
      child: IconButton(
          splashRadius: 22,
          onPressed: onPressed,
          icon: icon),
    );
  }
}
