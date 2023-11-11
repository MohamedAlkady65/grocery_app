part of 'change_password_cubit.dart';

@immutable
sealed class ChangePasswordState {}

final class ChangePasswordInitial extends ChangePasswordState {}

final class ChangePasswordLoading extends ChangePasswordState {}

final class ChangePasswordFailure extends ChangePasswordState {}

final class ChangePasswordSuccess extends ChangePasswordState {}

final class ChangePasswordError extends ChangePasswordState {}

class ChangeFormData {
  String? currentPassword;
  String? password;
  String? passwordConfirm;
}

class ChangeFormErrorMessages {
  String? currentPassword;
  String? newPassword;
  String? newPasswordConfirm;
  void clear() {
    currentPassword = null;
    newPassword = null;
    newPasswordConfirm = null;
  }
}
