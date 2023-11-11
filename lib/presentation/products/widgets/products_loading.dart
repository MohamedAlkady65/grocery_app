import 'package:flutter/material.dart';
import 'package:grocery_app/presentation/components/custom_shimmer.dart';
import 'package:grocery_app/presentation/components/shimmer_item.dart';

class ProductsLoading extends StatelessWidget {
  const ProductsLoading({
    super.key,
    this.padding,
    this.itemCount = 6,
  });
  final EdgeInsets? padding;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      period: const Duration(milliseconds: 900),
      child: GridView.builder(
        padding: padding,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 180,
            childAspectRatio: 0.77,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15),
        itemCount: itemCount,
        itemBuilder: (context, index) => const ShimmerItem(
          borderRadius: 8,
        ),
      ),
    );
  }
}
