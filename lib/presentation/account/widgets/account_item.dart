import 'package:flutter/material.dart';
import 'package:grocery_app/constants/style.dart';

class AccountItem extends StatelessWidget {
  const AccountItem(
      {super.key,
      required this.text,
      required this.icon,
      this.onTap,
      this.arrow = true,
      this.screenId})
      : assert(onTap == null || screenId == null);
  final String text;
  final String? screenId;
  final IconData icon;
  final void Function()? onTap;
  final bool arrow;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 32),
      horizontalTitleGap: 8,
      leading: Transform.flip(
        flipX: !arrow,
        child: Icon(
          icon,
          color: MyColors.green,
          size: 30,
        ),
      ),
      title: Text(
        text,
        style: TextStyle(
            fontWeight: MyFontWeights.semiBold,
            fontSize: 14,
            color: MyColors.text),
      ),
      trailing: arrow
          ? const Icon(
              Icons.arrow_forward_ios,
              color: MyColors.textSecondry,
            )
          : null,
      onTap: onTap ??
          (screenId != null
              ? () {
                  Navigator.pushNamed(context, screenId!);
                }
              : null),
    );
  }
}
