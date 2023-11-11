import 'package:flutter/material.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/presentation/components/custom_shimmer.dart';
import 'package:grocery_app/presentation/components/shimmer_item.dart';

class ReviewsLoading extends StatelessWidget {
  const ReviewsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.all(16),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return item();
        },
        separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
        itemCount: 3);
  }

  Container item() {
    return Container(
      color: MyColors.backgroundPrimary,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: CustomShimmer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const ShimmerItem.circle(
                  size: 50,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 150,
                        height: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 200,
                        height: 14,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
            const Divider(
              color: MyColors.border,
              thickness: 1,
              height: 30,
            ),
            const ShimmerItem(
              height: 18,
              width: 150,
            ),
            const SizedBox(
              height: 5,
            ),
            const ShimmerItem(
              height: 22,
            )
          ],
        ),
      ),
    );
  }
}
