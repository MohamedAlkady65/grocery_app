import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:grocery_app/constants/enums.dart';
import 'package:grocery_app/data/services/forgot_password_services.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:meta/meta.dart';
part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordInitial());
  ForgotPasswordServices forgotPasswordServices = ForgotPasswordServices();
  GlobalKey<FormState> formKey = GlobalKey();
  String? errorMessage;
  String? email;
  void sendResetLink(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      emit(ForgotPasswordSendLinkLoading());
      final response =
          await forgotPasswordServices.sendResetLink(email: email!);
      if (response == ForgotPasswordResponse.success) {
        emit(ForgotPasswordSendLinkSuccess());
      } else if (response == ForgotPasswordResponse.failure) {
        emit(ForgotPasswordSendLinkError());
      } else {
        if (response == ForgotPasswordResponse.invalidEmail) {
          if (context.mounted) {
            errorMessage = S.of(context).enterValidEmail;
          } else {
        errorMessage = "Error";
      }
        } else if (response == ForgotPasswordResponse.userNotFound) {
          if (context.mounted) {
            errorMessage = S.of(context).noAccountWithThisEmail;
          } else {
        errorMessage = "Error";
      }
        }
        formKey.currentState!.validate();
        errorMessage = null;
        emit(ForgotPasswordSendLinkFailure());
      }
    }
  }

  void resendResetLink() async {
    emit(ForgotPasswordSendLinkLoading());
    final response = await forgotPasswordServices.sendResetLink(email: email!);
    if (response == ForgotPasswordResponse.success) {
      emit(ForgotPasswordSendLinkSuccess());
    } else {
      emit(ForgotPasswordSendLinkError());
    }
  }

  @override
  void emit(ForgotPasswordState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
