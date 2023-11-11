import 'package:flutter/material.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/presentation/components/custom_text_button.dart';

class AuthTemplate extends StatelessWidget {
  const AuthTemplate(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.buttomMessage,
      required this.buttomTextButtonText,
      this.buttomTextButtonOnPressed,
      required this.children,
      this.welcome = false});
  final String image;
  final String title;
  final String subTitle;
  final String buttomMessage;
  final String buttomTextButtonText;
  final void Function()? buttomTextButtonOnPressed;
  final List<Widget> children;
  final bool welcome;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        height: height,
        child: Stack(
          children: [
            backgroundImage(height),
            // sheet(height),
            Visibility(
              visible: welcome,
              child: welcomeAtTop(context),
            )
          ],
        ),
      ),
      bottomSheet: sheet(),
    );
  }

  Positioned welcomeAtTop(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Colors.black,
              Colors.transparent,
            ])),
        height: 130,
        child: Center(
          child: Text(
            S.of(context).welcome,
            style: TextStyle(
                fontSize: 18,
                fontWeight: MyFontWeights.medium,
                color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget sheet() {
    return ColoredBox(
      color: MyColors.backgroundSecondry,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 20),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ...welcomeMessage(),
              const SizedBox(
                height: 25,
              ),
              ...children,
              bottomMessage()
            ]),
      ),
    );
  }

  List<Text> welcomeMessage() => [
        Text(
          title,
          style: TextStyle(
              color: MyColors.text,
              fontWeight: MyFontWeights.semiBold,
              fontSize: 25),
        ),
        Text(
          subTitle,
          style: TextStyle(
              color: MyColors.textSecondry,
              fontWeight: MyFontWeights.medium,
              fontSize: 15),
        ),
      ];

  Row bottomMessage() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            buttomMessage,
            style: TextStyle(
                color: MyColors.textSecondry,
                fontWeight: MyFontWeights.regular,
                fontSize: 15),
          ),
          CustomTextButton(
            onPressed: buttomTextButtonOnPressed,
            color: MyColors.text,
            child: Text(
              buttomTextButtonText,
              style: TextStyle(
                  color: MyColors.text,
                  fontWeight: MyFontWeights.medium,
                  fontSize: 15),
            ),
          )
        ],
      );

  Image backgroundImage(double height) {
    return Image.asset(
      image,
      width: double.infinity,
      height: height * 0.7,
      fit: BoxFit.cover,
      alignment: Alignment.topCenter,
    );
  }
}
