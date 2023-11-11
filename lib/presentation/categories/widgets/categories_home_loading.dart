import 'package:flutter/material.dart';
import 'package:grocery_app/presentation/components/custom_shimmer.dart';
import 'package:grocery_app/presentation/components/shimmer_item.dart';

class CategoriesHomeLoading extends StatelessWidget {
  const CategoriesHomeLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => const SizedBox(
          width: 22,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) => item(),
      ),
    );
  }

  Column item() {
    return const Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ShimmerItem.circle(size: 65),
          ShimmerItem(
            height: 10,
            width: 50,
          ),
        ]);
  }
}
