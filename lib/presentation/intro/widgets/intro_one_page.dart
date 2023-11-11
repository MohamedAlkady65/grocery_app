import 'package:flutter/material.dart';
import 'package:grocery_app/constants/style.dart';

class IntroOnePage extends StatelessWidget {
  const IntroOnePage(
      {super.key,
      required this.image,
      required this.title,
      required this.content});
  final String title;
  final String content;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          image,
          width: double.infinity,
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                  top: -50,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.elliptical(220, 50)),
                      color: MyColors.backgroundPrimary,
                    ),
                  )),
              Container(
                color: MyColors.backgroundPrimary,
                height: 170,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontWeight: MyFontWeights.bold,
                        height: 1.2,
                        fontSize: 30,
                        color: MyColors.text),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    content,
                    style: TextStyle(
                        fontWeight: MyFontWeights.medium,
                        fontSize: 15,
                        color: MyColors.textSecondry),
                    textAlign: TextAlign.center,
                  ),
                ]),
              ),
            ],
          ),
        )
      ],
    );
  }
}
