import 'package:flutter/material.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/generated/l10n.dart';

class NoConnectionWidget extends StatelessWidget {
  const NoConnectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.wifi_tethering_off,
          color: MyColors.primaryDark,
          size: 100,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          S.of(context).noInternetConnection,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: MyColors.text,
              fontWeight: MyFontWeights.medium,
              fontSize: 22),
        ),
        Text(
          S.of(context).checkYourConnectionAndRetryAgain,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: MyColors.textSecondry,
              fontWeight: MyFontWeights.medium,
              fontSize: 14),
        ),
      ],
    );
  }
}
