import 'package:bloc/bloc.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:meta/meta.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/constants/enums.dart';
import 'package:grocery_app/data/models/phone_model.dart';
import 'package:grocery_app/data/services/phone_services.dart';
import 'package:grocery_app/data/services/sign_up_service.dart';
import 'package:grocery_app/helper/phone.dart';
import 'package:grocery_app/logic/auth/email_verify_cubit/email_verify_cubit.dart';
import 'package:grocery_app/logic/info_cubit/info_cubit.dart';
import 'package:phone_number/phone_number.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.infoCubit) : super(SignUpInitial());
  final InfoCubit infoCubit;
  SignUpService signUpService = SignUpService();

  GlobalKey<FormState> signUpFormKey = GlobalKey();

  SignUpFormData signUpFormData = SignUpFormData();

  SignUpFormErrorMessages signUpFormErrorMessages = SignUpFormErrorMessages();

  PhoneServices phoneServices = PhoneServices();

  PhoneModel? phoneNumber;
  void signUp(BuildContext context) async {
    signUpFormKey.currentState!.save();

    phoneNumber = await validatePhone(context, infoCubit.ipInfo?.countryCode2);

    validatePassowrdMatch(context);
    if (!await checkInternet()) {
      return;
    }
    emit(SignUpLoading());
    DataResponse? response;
    if (context.mounted) {
      response = await checkPhoneExists(context);
    }
    if (response == null || response == DataResponse.failure) {
      emit(SignUpFailure());
      return;
    }

    if (signUpFormKey.currentState!.validate()) {
      final res = await signUpService.signUp(
          email: signUpFormData.email!,
          username: signUpFormData.username!,
          phone: phoneNumber!,
          password: signUpFormData.password!);

      if (res.response == SingUpResponse.success) {
        infoCubit.currentUser = res.userInfo;

        final emailVerifyCubit = await verifyEmail();

        if (emailVerifyCubit == null) {
          emit(SignUpFailure());
        } else {
          emit(SignUpSuccess(emailVerifyCubit: emailVerifyCubit));
        }
      } else if (res.response == SingUpResponse.failure) {
        emit(SignUpFailure());
      } else {
        if (res.response == SingUpResponse.invalidEmail) {
          if (context.mounted) {
            signUpFormErrorMessages.email = S.of(context).enterValidEmail;
          } else {
            signUpFormErrorMessages.email = "Error";
          }
        } else if (res.response == SingUpResponse.emailAlreadyUsed) {
          if (context.mounted) {
            signUpFormErrorMessages.email = S.of(context).emailIsAlreadyUsed;
          } else {
            signUpFormErrorMessages.email = "Error";
          }
        } else if (res.response == SingUpResponse.weakPassword) {
          if (context.mounted) {
            signUpFormErrorMessages.password = S.of(context).passwordIsTooWeak;
          } else {
            signUpFormErrorMessages.password = "Error";
          }
        }
        signUpFormKey.currentState!.validate();
        signUpFormErrorMessages.clear();
        emit(SignUpWrong());
      }
    } else {
      emit(SignUpInitial());
    }
  }

  Future<DataResponse> checkPhoneExists(BuildContext context) async {
    if (phoneNumber != null) {
      final response = await phoneServices.checkPhoneExists(phoneNumber!);

      if (response.state == DataResponse.success) {
        if (context.mounted) {
          signUpFormErrorMessages.phone =
              response.exists ? S.of(context).phoneIsAlreadyUsed : null;
        } else {
          signUpFormErrorMessages.phone = "Error";
        }
      }
      return response.state;
    } else {
      return DataResponse.success;
    }
  }

  void validatePassowrdMatch(BuildContext context) {
    if (signUpFormData.password != signUpFormData.passwordConfirm) {
      signUpFormErrorMessages.passwordConfirm =
          S.of(context).makeSureYourPasswordsMatch;
    } else {
      signUpFormErrorMessages.passwordConfirm = null;
    }
  }

  Future<PhoneModel?> validatePhone(BuildContext context, String? code) async {
    PhoneNumber? phoneNumber =
        await PhoneParser.parse(phone: signUpFormData.phone, code: code);

    if (phoneNumber == null) {
      if (context.mounted) {
        signUpFormErrorMessages.phone = S.of(context).enterValidPhone;
      } else {
        signUpFormErrorMessages.phone = "Error";
      }

      return null;
    } else {
      signUpFormErrorMessages.phone = null;
      return PhoneModel.fromPhoneNumberObject(phoneNumber);
    }
  }

  Future<EmailVerifyCubit?> verifyEmail() async {
    EmailVerifyCubit emailVerifyCubit = EmailVerifyCubit(
        email: signUpFormData.email ?? "", phone: phoneNumber!);
    final emailRes = await emailVerifyCubit.sendVerficationLinkEmail();
    if (emailRes == DataResponse.failure) {
      emailVerifyCubit.close();
      return null;
    }
    emailVerifyCubit.verifyEmail();
    return emailVerifyCubit;
  }

  Future<bool> checkInternet() async {
    final response = await Connectivity().checkConnectivity();

    if (response == ConnectivityResult.none) {
      emit(NoInternet());
      return false;
    }

    return true;
  }

  @override
  void emit(SignUpState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}

class SignUpFormData {
  String? email;
  String? username;
  String? phone;
  String? password;
  String? passwordConfirm;
}

class SignUpFormErrorMessages {
  String? email;
  String? username;
  String? phone;
  String? password;
  String? passwordConfirm;
  void clear() {
    email = null;
    username = null;
    phone = null;
    password = null;
    passwordConfirm = null;
  }
}
