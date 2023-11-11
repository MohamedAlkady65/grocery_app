import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/generated/l10n.dart';

class EmptyFavorites extends StatelessWidget {
  const EmptyFavorites({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          FontAwesomeIcons.heart,
          color: MyColors.primaryDark,
          size: 200,
        ),
    const    SizedBox(
          height: 20,
        ),
        Text(
          S.of(context).yourFavoraitesIsEmpty,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 25,
              fontWeight: MyFontWeights.semiBold,
              color: MyColors.text),
        )
      ],
    );
  }
}
