import 'package:flutter/material.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/presentation/components/custom_shimmer.dart';
import 'package:grocery_app/presentation/components/shimmer_item.dart';

class CartLoading extends StatelessWidget {
  const CartLoading({super.key});

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

  Container item() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: MyColors.backgroundPrimary,
      ),
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
                      height: 14,
                      width: 80,
                    ),
                    ShimmerItem(
                      height: 12,
                      width: 100,
                    ),
                    ShimmerItem(
                      height: 16,
                      width: 100,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
