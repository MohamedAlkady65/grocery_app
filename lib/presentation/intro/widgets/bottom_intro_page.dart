import 'package:flutter/material.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/presentation/components/custom_text_button.dart';
import 'package:grocery_app/presentation/intro/widgets/page_indicator.dart';
import 'package:grocery_app/constants/style.dart';

class BottomIntroPage extends StatelessWidget {
  const BottomIntroPage({
    super.key,
    required this.controller,
  });

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.topCenter,
      color: MyColors.backgroundPrimary,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        buildTextButton(
          text: S.of(context).skip,
          color: MyColors.textSecondry,
          onPressed: () {
            controller.animateToPage(3,
                duration: const Duration(milliseconds: 500),
                curve: Curves.linear);
          },
        ),
        PageIndicator(
          controller: controller,
          count: 4,
        ),
        buildTextButton(
            text: S.of(context).next,
            color: MyColors.primaryDark,
            onPressed: () {
              controller.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.linear);
            })
      ]),
    );
  }

  CustomTextButton buildTextButton(
      {required String text,
      required Color color,
      required void Function()? onPressed}) {
    return CustomTextButton(
        onPressed: onPressed,
        color: color,
        child: Text(text,
            style: TextStyle(
                color: color, fontWeight: MyFontWeights.medium, fontSize: 15)));
  }
}
