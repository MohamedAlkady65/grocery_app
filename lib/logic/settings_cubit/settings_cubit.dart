import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:meta/meta.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());
  bool? isDarkTheme;
  Locale? locale;
  void toggleDarkTheme(bool value) {
    isDarkTheme = value;
    if (value) {
      MyColors.setDarkTheme();
      emit(SettingsToggleTheme());
    } else {
      MyColors.setLightTheme();
      emit(SettingsToggleTheme());
    }
  }

  void setLocale(String code) {
    locale = Locale(code);
    emit(SettingsChangeLocale());
  }

  @override
  void emit(SettingsState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
