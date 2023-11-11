import 'package:flutter/widgets.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImagesIndicator extends StatelessWidget {
  const ImagesIndicator({
    super.key,
    required this.controller, required this.count,
  });
  final PageController controller;
  final int count;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 12,
        child: Align(
          alignment: Alignment.center,
          child: SmoothPageIndicator(
            controller: controller,
            count: count,
            effect:  const WormEffect(
                dotColor: MyColors.textSecondry,
                activeDotColor: MyColors.primaryDark,
                dotWidth: 8,
                dotHeight: 8),
          ),
        ));
  }
}
