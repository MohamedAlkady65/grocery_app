import 'package:flutter/material.dart';
import 'package:grocery_app/presentation/components/switch_button.dart';
import 'package:grocery_app/constants/style.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem(
      {super.key,
      required this.title,
      required this.subTitle,
      this.onChanged,
      this.initialValue = false});

  final String title;
  final String subTitle;
  final void Function(bool)? onChanged;
  final bool initialValue;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: MyColors.backgroundPrimary,
      contentPadding: const EdgeInsets.all(16),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          title,
          style: TextStyle(
              fontSize: 15,
              fontWeight: MyFontWeights.semiBold,
              color: MyColors.text),
        ),
      ),
      subtitle: Text(
        subTitle,
        style: TextStyle(
            fontSize: 12,
            fontWeight: MyFontWeights.medium,
            color: MyColors.textSecondry),
      ),
      trailing: SwitchButton(
        scale: 0.8,
        initialValue: initialValue,
        onChanged: onChanged,
      ),
    );
  }
}
