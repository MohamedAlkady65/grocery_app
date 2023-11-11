import 'package:flutter/material.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/presentation/auth/widgets/auth_welcome_screen.dart';
import 'package:grocery_app/presentation/components/bright_button.dart';
import 'package:grocery_app/constants/style.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 80,
      alignment: Alignment.topCenter,
      color: MyColors.backgroundPrimary,
      child: BrightButton(
        text: S.of(context).getStarted,
        onTap: () {
          Navigator.pushNamed(context, AuthWelcomeScreen.id);
        },
      ),
    );
  }
}
