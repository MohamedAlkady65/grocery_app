import 'package:flutter/material.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/presentation/components/custom_shimmer.dart';
import 'package:grocery_app/presentation/components/shimmer_item.dart';

class MyOrdersLoading extends StatelessWidget {
  const MyOrdersLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      separatorBuilder: (context, index) => const SizedBox(
        height: 2,
      ),
      itemCount: 4,
      itemBuilder: (context, index) => item(),
    );
  }

  CustomShimmer item() => CustomShimmer(
        child: ListTile(
          tileColor: MyColors.backgroundPrimary,
          contentPadding:
              const EdgeInsets.only(left: 12, right: 12, top: 18, bottom: 8),
          horizontalTitleGap: 12,
          isThreeLine: true,
          title: Container(
            alignment: Alignment.centerLeft,
            child: const ShimmerItem(
              height: 20,
              width: 140,
            ),
          ),
          subtitle: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 4,
              ),
              ShimmerItem(
                height: 16,
                width: 70,
              ),
              SizedBox(
                height: 3,
              ),
              ShimmerItem(
                height: 16,
                width: 180,
              ),
              SizedBox(
                height: 4,
              ),
              ShimmerItem(
                height: 14,
                width: 70,
              ),
              SizedBox(
                height: 4,
              ),
              ShimmerItem(
                height: 14,
                width: 120,
              ),
            ],
          ),
          leading: const ShimmerItem.circle(size: 66),
        ),
      );
}
