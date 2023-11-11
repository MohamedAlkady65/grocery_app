// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/logic/settings_cubit/settings_cubit.dart';
import 'package:grocery_app/presentation/settings/widgets/settings_item.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SettingsItem(
            title: S.of(context).allowNotifcations,
            subTitle: S.of(context).lorem,
          ),
          const SizedBox(
            height: 12,
          ),
          SettingsItem(
            title: S.of(context).darkmode,
            subTitle: S.of(context).lorem,
            initialValue:
                BlocProvider.of<SettingsCubit>(context).isDarkTheme ?? false,
            onChanged: (value) {
              BlocProvider.of<SettingsCubit>(context).toggleDarkTheme(value);
            },
          ),
          const SizedBox(
            height: 12,
          ),
          SettingsItem(
            title: S.of(context).language,
            subTitle: S.of(context).lorem,
            initialValue:
                BlocProvider.of<SettingsCubit>(context).locale?.languageCode ==
                        "ar"
                    ? true
                    : false,
            onChanged: (value) {
              BlocProvider.of<SettingsCubit>(context)
                  .setLocale(value ? "ar" : "en");
            },
          ),
        ],
      ),
    );
  }
}
