part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class SettingsToggleTheme extends SettingsState {

}

final class SettingsChangeLocale extends SettingsState {
}
