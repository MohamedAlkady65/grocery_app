import 'package:flutter/material.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/presentation/components/custom_shimmer.dart';
import 'package:grocery_app/presentation/components/shimmer_item.dart';

class OrderDetailsLoading extends StatelessWidget {
  const OrderDetailsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                    S.of(context).orderDetails,
              style: TextStyle(
                  fontSize: 22,
                  color: MyColors.text,
                  fontWeight: MyFontWeights.semiBold),
            ),
            const SizedBox(
              height: 15,
            ),
            orderDetailSection(context),
            const SizedBox(
              height: 25,
            ),
            Text(
                    S.of(context).orderItems,
              style: TextStyle(
                  fontSize: 22,
                  color: MyColors.text,
                  fontWeight: MyFontWeights.semiBold),
            ),
            const SizedBox(
              height: 15,
            ),
            orderItemsList()
          ],
        ),
      ),
    );
  }

  Widget orderDetailSection(BuildContext context) {
    return Column(
      children: [
        orderOneInfo(title: S.of(context).orderId, width: 140),
        divider(),
        orderOneInfo(title:S.of(context).date, width: 180),
        divider(),
        orderOneInfo(
          title:  S.of(context).totalPrice,
        ),
        divider(),
        orderOneInfo(title:  S.of(context).items, width: 60),
        divider(),
        orderOneInfo(
          title: S.of(context).addressS,
          child: addressChild(),
        ),
        divider(),
        orderOneInfo(title:  S.of(context).paymentMethod, width: 100),
      ],
    );
  }

  SizedBox addressChild() {
    return SizedBox(
      width: 130,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) => const SizedBox(
          height: 8,
        ),
        itemCount: 4,
        itemBuilder: (context, index) => const ShimmerItem(
          width: 120,
          height: 15,
        ),
      ),
    );
  }

  Widget orderOneInfo(
      {required String title, Widget? child, double width = 120}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 16,
              color: MyColors.text,
              fontWeight: MyFontWeights.medium),
        ),
        CustomShimmer(
          child: child ??
              ShimmerItem(
                width: width,
                height: 18,
              ),
        ),
      ],
    );
  }

  Divider divider() {
    return const Divider(
      thickness: 1,
      color: MyColors.grey,
    );
  }

  Widget orderItemsList() {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
      itemCount: 2,
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
