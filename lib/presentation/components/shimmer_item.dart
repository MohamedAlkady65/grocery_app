import 'package:flutter/material.dart';

class ShimmerItem extends StatelessWidget {
  const ShimmerItem(
      {super.key,
      this.width = double.infinity,
      this.height = double.infinity,
      this.borderRadius = 0})
      : circle = false,
        size = 0;

  const ShimmerItem.circle({
    super.key,
    required this.size,
  })  : circle = true,
        borderRadius = 0,
        height = 0,
        width = 0;
  final double width;
  final double height;
  final double size;
  final bool circle;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: circle ? null : BorderRadius.circular(borderRadius),
          color: Colors.white,
          shape: circle ? BoxShape.circle : BoxShape.rectangle),
      width: circle ? size : width,
      height: circle ? size : height,
    );
  }
}
