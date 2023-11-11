import 'package:flutter/material.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/presentation/components/custom_shimmer.dart';
import 'package:grocery_app/presentation/components/shimmer_item.dart';

class FavoritesLoading extends StatelessWidget {
  const FavoritesLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
      itemCount: 4,
      itemBuilder: (context, index) => item(),
    );
  }

  dynamic item() {
    return Container(
      decoration: BoxDecoration(
          color: MyColors.backgroundPrimary,
          borderRadius: BorderRadius.circular(6)),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      height: 100,
      child: CustomShimmer(
        child: Row(
          children: [
            Container(
              width: 100,
              padding: const EdgeInsets.all(8),
              child: const ShimmerItem(
                borderRadius: 8,
              ),
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerItem(
                      height: 18,
                    ),
                    ShimmerItem(
                      height: 16,
                      width: 80,
                    ),
                    ShimmerItem(
                      height: 16,
                      width: 100,
                    ),
                  ],
                ),
              ),
            ),
            const Icon(
              Icons.favorite,
              color: MyColors.red,
              size: 40,
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }
}
