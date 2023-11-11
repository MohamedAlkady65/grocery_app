import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/presentation/auth/sign_in/sign_in_screen.dart';
import 'package:grocery_app/presentation/auth/widgets/auth_template.dart';
import 'package:grocery_app/presentation/components/bright_button.dart';
import 'package:grocery_app/presentation/components/custom_button.dart';
import 'package:grocery_app/presentation/auth/sign_up/sign_up_screen.dart';

class AuthWelcomeScreen extends StatelessWidget {
  const AuthWelcomeScreen({super.key});
  static const String id = "AuthWelcomeScreen";
  @override
  Widget build(BuildContext context) {
    return AuthTemplate(
        image: "assets/images/auth/auth_welcome.png",
        title: S.of(context).welcome,
        subTitle: S.of(context).lorem,
        buttomMessage: S.of(context).alreadyHaveAnAccount,
        buttomTextButtonText: S.of(context).login,
        buttomTextButtonOnPressed: () {
          Navigator.pushNamed(context, SignInScreen.id);
        },
        welcome: true,
        children: [
          CustomButton(
            text: S.of(context).continueWithGoogle,
            onTap: () {},
            icon: SvgPicture.asset("assets/images/google_icon.svg"),
          ),
          const SizedBox(
            height: 12,
          ),
          BrightButton(
            text: S.of(context).createAccount,
            onTap: () {
              Navigator.pushNamed(context, SignUpScreen.id);
            },
          ),
        ]);
  }
}
