import 'package:flutter/material.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/presentation/components/custom_shimmer.dart';
import 'package:grocery_app/presentation/components/shimmer_item.dart';

class CategoriesLoading extends StatelessWidget {
  const CategoriesLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 120, mainAxisSpacing: 10, crossAxisSpacing: 10),
      itemCount: 6,
      itemBuilder: (context, index) => item(),
    );
  }

  Container item() {
    return Container(
      color: MyColors.backgroundPrimary,
      child: const CustomShimmer(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          ShimmerItem.circle(size: 65),
          ShimmerItem(
            height: 10,
            width: 50,
          ),
        ]),
      ),
    );
  }
}
