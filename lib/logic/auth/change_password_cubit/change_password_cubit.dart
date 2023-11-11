import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/constants/enums.dart';
import 'package:grocery_app/data/services/change_password_services.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:meta/meta.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());
  ChangeFormData formData = ChangeFormData();
  ChangeFormErrorMessages formErrorMessages = ChangeFormErrorMessages();
  GlobalKey<FormState> formKey = GlobalKey();
  ChangePasswordServices changePasswordServices = ChangePasswordServices();

  Future<void> changePassword(BuildContext context) async {
    formKey.currentState!.save();

    if (formData.password != formData.passwordConfirm) {
      formErrorMessages.newPasswordConfirm =
          S.of(context).makeSureYourNewPasswordsMatch;
    } else {
      formErrorMessages.newPasswordConfirm = null;
    }

    if (formKey.currentState!.validate()) {
      emit(ChangePasswordLoading());
      final response = await changePasswordServices.changePassword(
          currentPassword: formData.currentPassword!,
          newPassword: formData.password!);

      if (response == ChangePasswordResponse.success) {
        emit(ChangePasswordSuccess());
      } else if (response == ChangePasswordResponse.failure) {
        emit(ChangePasswordError());
      } else {
        if (response == ChangePasswordResponse.wrongCurrentPassword) {
          if (context.mounted) {
            formErrorMessages.currentPassword =
                S.of(context).currentPasswordIsIncorrect;
          } else {
            formErrorMessages.currentPassword = "Error";
          }
        } else if (response == ChangePasswordResponse.weakNewPassword) {
          if (context.mounted) {
            formErrorMessages.newPassword = S.of(context).passwordIsTooWeak;
          } else {
            formErrorMessages.newPassword = "Error";
          }
        }
        formKey.currentState!.validate();
        formErrorMessages.clear();
        emit(ChangePasswordFailure());
      }
    }
  }

  @override
  void emit(ChangePasswordState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
