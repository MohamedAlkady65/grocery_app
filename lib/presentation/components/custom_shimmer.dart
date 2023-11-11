import 'package:flutter/material.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({
    super.key,
    required this.child,
    this.period = const Duration(milliseconds: 1500),
  });
  final Widget child;
  final Duration period;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: period,
      baseColor: MyColors.shimmerBaseColor,
      highlightColor: MyColors.shimmerHighlightColor,
      child: child,
    );
  }
}
