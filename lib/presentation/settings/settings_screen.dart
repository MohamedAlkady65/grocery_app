import 'package:flutter/material.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/presentation/components/check_connection.dart';
import 'package:grocery_app/presentation/components/custom_app_bar.dart';
import 'package:grocery_app/presentation/settings/widgets/settings_body.dart';
import 'package:grocery_app/constants/style.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const String id = "SettingsScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundSecondry,
      appBar: CustomAppBar(
        title: S.of(context).settings,
      ),
      body: CheckConnection(child: SettingsBody()),
    );
  }
}
