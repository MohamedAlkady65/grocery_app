import 'package:flutter/material.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/generated/l10n.dart';

class ChooseAddressEmptyBody extends StatelessWidget {
  const ChooseAddressEmptyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.location_on_outlined,
          size: 170,
          color: MyColors.primaryDark,
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          S.of(context).noAddressesYet,
          style: TextStyle(
              fontSize: 25,
              fontWeight: MyFontWeights.semiBold,
              color: MyColors.text),
        )
      ],
    );
  }
}
