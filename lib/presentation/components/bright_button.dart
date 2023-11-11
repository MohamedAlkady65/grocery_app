import 'package:flutter/material.dart';
import 'package:grocery_app/constants/style.dart';

class BrightButton extends StatelessWidget {
  const BrightButton({
    super.key,
    required this.text,
    this.onTap,
    this.icon,
    this.left = true,
    this.isLoading = false,
  });
  final String text;
  final void Function()? onTap;
  final Widget? icon;
  final bool left;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isLoading,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          gradient: const LinearGradient(colors: [
            MyColors.primary,
            Color(0xff85CE43),
            Color(0xff85CE43),
            MyColors.primaryDark,
          ]),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Material(
            color: Colors.transparent,
            type: MaterialType.button,
            child: InkWell(
              onTap: onTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  left && icon != null ? icon! : const SizedBox(),
                  isLoading
                      ? CircularProgressIndicator(
                          color: MyColors.backgroundPrimary,
                        )
                      : Text(
                          text,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: MyFontWeights.semiBold,
                              color: MyColors.backgroundPrimary),
                        ),
                  !left && icon != null ? icon! : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

