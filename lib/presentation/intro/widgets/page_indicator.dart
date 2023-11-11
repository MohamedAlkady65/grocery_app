import 'package:flutter/material.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator(
      {super.key, required this.controller, required this.count});
  final PageController controller;
  final int count;
  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
        controller: controller,
        count: 4,
        effect:  const JumpingDotEffect(
            verticalOffset: 5,
            activeDotColor: MyColors.primaryDark,
            dotColor: MyColors.grey,
            dotWidth: 8,
            dotHeight: 8));
  }
}
