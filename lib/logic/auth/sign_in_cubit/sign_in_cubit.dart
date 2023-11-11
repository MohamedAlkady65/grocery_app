import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/constants/enums.dart';
import 'package:grocery_app/data/models/phone_model.dart';
import 'package:grocery_app/data/models/user_model.dart';
import 'package:grocery_app/data/services/sign_in_service.dart';
import 'package:grocery_app/logic/auth/email_verify_cubit/email_verify_cubit.dart';
import 'package:grocery_app/logic/info_cubit/info_cubit.dart';
import 'package:meta/meta.dart';
part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this.infoCubit) : super(SignInInitial());
  SignInService signInService = SignInService();
  GlobalKey<FormState> signInFormKey = GlobalKey();
  SignInFormData signInFormData = SignInFormData();
  final InfoCubit infoCubit;

  void signIn() async {
    signInFormKey.currentState!.save();

    if (signInFormKey.currentState!.validate()) {
      if (!await checkInternet()) {
        return;
      }

      emit(SignInLoading());
      final response = await signInService.signIn(
          email: signInFormData.email!, password: signInFormData.password!);

      if (response.state == SingInResponse.success) {
        if (response.user == null) {
          emit(SignInFailure());
          return;
        }

        infoCubit.currentUser = response.user!;

        if (!FirebaseAuth.instance.currentUser!.emailVerified) {
          final emailVerifyCubit =
              await verifyEmail(user: infoCubit.currentUser!);

          if (emailVerifyCubit != null) {
            emit(
                SignInSuccessGoVerifyEmail(emailVerifyCubit: emailVerifyCubit));
          } else {
            emit(SignInFailure());
          }
        } else if (!response.user!.phoneVerified) {
          emit(SignInSuccessGoVerifyPhone());
        } else {
          emit(SignInSuccessGoHome());
        }
      } else if (response.state == SingInResponse.failure) {
        emit(SignInFailure());
      } else if (response.state == SingInResponse.wrong) {
        emit(SignInWrong());
      }
    }
  }

  void verifyPhone({required PhoneModel phone}) {}

  Future<EmailVerifyCubit?> verifyEmail({required UserModel user}) async {
    EmailVerifyCubit emailVerifyCubit =
        EmailVerifyCubit(email: user.email, phone: user.phone);
    final emailRes = await emailVerifyCubit.sendVerficationLinkEmail();
    if (emailRes == DataResponse.failure) {
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
  void emit(SignInState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}

class SignInFormData {
  String? email;
  String? password;
}
