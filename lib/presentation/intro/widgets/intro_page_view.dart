import 'package:flutter/material.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/presentation/intro/widgets/intro_one_page.dart';

class IntroPageView extends StatelessWidget {
  const IntroPageView(
      {super.key, required this.controller, this.onPageChanged});
  final PageController controller;
  final void Function(int)? onPageChanged;
  @override
  Widget build(BuildContext context) {
    return PageView(
        controller: controller,
        onPageChanged: onPageChanged,
        children: [
          IntroOnePage(
            title: S.of(context).premiumFoodAtYourDoorstep,
            content: S.of(context).lorem,
            image: "assets/images/intro/intro_1.png",
          ),
          IntroOnePage(
            title: S.of(context).buyPremiumQualityFruits,
            content: S.of(context).lorem,
            image: "assets/images/intro/intro_2.png",
          ),
          IntroOnePage(
            title: S.of(context).buyQualityDairyProducts,
            content: S.of(context).lorem,
            image: "assets/images/intro/intro_3.png",
          ),
          IntroOnePage(
            title: S.of(context).getDiscountsOnAllProducts,
            content: S.of(context).lorem,
            image: "assets/images/intro/intro_4.png",
          ),
        ]);
  }
}
