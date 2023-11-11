import 'package:flutter/material.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LandingIndicator extends StatelessWidget {
  const LandingIndicator({
    super.key,
    required this.controller,
  });
  final PageController controller;
  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: isArabic() ? null : 30,
        right: isArabic() ? 30 : null,
        bottom: 35,
        child: SizedBox(
          width: 160,
          child: SmoothPageIndicator(
            controller: controller,
            count: 4,
            effect: ExpandingDotsEffect(
                dotColor: MyColors.backgroundPrimary,
                activeDotColor: MyColors.primaryDark,
                dotWidth: 8,
                dotHeight: 8),
          ),
        ));
  }
}
