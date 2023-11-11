import 'package:flutter/material.dart';
import 'package:grocery_app/presentation/intro/widgets/bottom_intro_page.dart';
import 'package:grocery_app/presentation/intro/widgets/get_started_button.dart';
import 'package:grocery_app/presentation/intro/widgets/intro_page_view.dart';
import 'package:grocery_app/constants/style.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});
  static const id = "IntroScreen";

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController controller = PageController();
  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundPrimary,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: IntroPageView(
          controller: controller,
          onPageChanged: (value) {
            setState(() {
              isLast = value == 3 ? true : false;
            });
          },
        ),
      ),
      bottomSheet: isLast
          ? const GetStartedButton()
          : BottomIntroPage(controller: controller),
    );
  }
}
