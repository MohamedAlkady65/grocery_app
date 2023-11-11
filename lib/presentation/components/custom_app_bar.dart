import 'package:flutter/material.dart';
import 'package:grocery_app/constants/style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.backIcon = true,
    this.actions,
    required this.title,
    this.color,
    this.backIconFunction,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;
  final bool backIcon;
  final List<Widget>? actions;
  final String title;
  final Color? color;
  final void Function()? backIconFunction;

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: backIcon
          ? IconButton(
              onPressed: backIconFunction ??
                  () {
                    Navigator.pop(context);
                  },
              splashRadius: 22,
              icon: Icon(
                Icons.arrow_back,
                color: MyColors.text,
              ),
              color: MyColors.text,
            )
          : null,
      actions: actions,
      backgroundColor: color ?? MyColors.backgroundPrimary,
      title: Text(
        title,
        style: TextStyle(
            fontSize: 18,
            fontWeight: MyFontWeights.medium,
            color: MyColors.text),
      ),
      centerTitle: true,
      elevation: 0,
    );
  }
}
