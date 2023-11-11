import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/presentation/home/home_screen.dart';
import 'package:grocery_app/presentation/components/bright_button.dart';
import 'package:grocery_app/constants/style.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        children: [
          const Spacer(
            flex: 1,
          ),
          Center(
            child: Column(
              children: [
                SvgPicture.asset(
                  "assets/images/cart_icon.svg",
                  width: 100,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  S.of(context).yourCartIsEmpty,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: MyFontWeights.semiBold,
                      color: MyColors.text),
                )
              ],
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          BrightButton(
            text: S.of(context).startShopping,
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeScreen.id, (route) => false);
            },
          )
        ],
      ),
    );
  }
}
