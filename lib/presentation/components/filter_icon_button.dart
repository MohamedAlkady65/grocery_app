import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/constants/style.dart';

class FilterIconButton extends StatelessWidget {
  const FilterIconButton({
    super.key,
    this.onTap,
  });
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(99999),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: null,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SvgPicture.asset(
                "assets/images/filter_icon.svg",
                color: MyColors.text,
              )),
        ),
      ),
    );
  }
}
