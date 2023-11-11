import 'package:flutter/material.dart';

class BottomAppBarItem extends StatelessWidget {
  const BottomAppBarItem(
      {super.key,
      required this.index,
      required this.iconData,
      this.onTap,
      required this.color});
  final int index;
  final Color color;
  final IconData iconData;
  final void Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 1,
      onPressed: () {
        if (onTap != null) {
          onTap!(index);
        }
      },
      icon: Icon(
        iconData,
        size: 30,
        color: color,
      ),
    );
  }
}
