import 'package:flutter/material.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/helper/functions.dart';

class ArrowButton extends StatelessWidget {
  const ArrowButton(
      {super.key,
      required this.iconData,
      required this.position,
      this.onPressed});
  final IconData iconData;
  final int position;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    int forCheck = isArabic() ? 1 : 0;
    return Positioned(
        top: 0,
        bottom: 0,
        left: position == forCheck ? 5 : null,
        right: position == forCheck ? null : 5,
        child: SizedBox(
          width: 50,
          height: 50,
          child: Material(
            type: MaterialType.circle,
            color: Colors.transparent,
            child: IconButton(
              icon: Icon(
                iconData,
              ),
              color: MyColors.textSecondry,
              splashRadius: 25,
              onPressed: onPressed,
            ),
          ),
        ));
  }
}
