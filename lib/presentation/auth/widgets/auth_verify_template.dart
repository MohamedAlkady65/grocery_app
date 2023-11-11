import 'package:flutter/material.dart';
import 'package:grocery_app/presentation/components/check_connection.dart';
import 'package:grocery_app/presentation/components/custom_app_bar.dart';
import 'package:grocery_app/constants/style.dart';

class AuthVefiyTemplate extends StatelessWidget {
  const AuthVefiyTemplate(
      {super.key,
      required this.appBarTitle,
      required this.title,
      required this.subtitle,
      required this.field,
      required this.button,
      this.additional,
      this.content});

  final String appBarTitle;
  final String title;
  final String subtitle;
  final String? content;
  final Widget field;
  final Widget button;
  final Widget? additional;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundSecondry,
      appBar: CustomAppBar(
        title: appBarTitle,
        color: MyColors.backgroundSecondry,
      ),
      body: CheckConnection(
        child: ListView(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 64),
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: MyFontWeights.semiBold,
                  fontSize: 25,
                  color: MyColors.text),
            ),
            content != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      content!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: MyFontWeights.medium,
                          fontSize: 16,
                          color: MyColors.text),
                    ),
                  )
                : const SizedBox(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: MyFontWeights.regular,
                    fontSize: 15,
                    color: MyColors.textSecondry),
              ),
            ),
            SizedBox(
              height: content == null ? 30 : 15,
            ),
            field,
            const SizedBox(
              height: 20,
            ),
            button,
            additional == null ? const SizedBox() : additional!
          ],
        ),
      ),
    );
  }
}
