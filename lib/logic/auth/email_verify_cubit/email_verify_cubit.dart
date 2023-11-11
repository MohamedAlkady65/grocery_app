import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/constants/enums.dart';
import 'package:grocery_app/data/models/phone_model.dart';
import 'package:grocery_app/data/services/email_services.dart';
import 'package:meta/meta.dart';

part 'email_verify_state.dart';

class EmailVerifyCubit extends Cubit<EmailVerifyState> {
  EmailVerifyCubit({required this.email, required this.phone})
      : super(EmailVerifyInitial());
  EmailServices emailServices = EmailServices();
  String email;
  PhoneModel phone;

  Future<DataResponse> sendVerficationLinkEmail() async {
    final response = await emailServices.sendVerficationLinkEmail();

    if (response == DataResponse.failure) {
      FirebaseAuth.instance.currentUser?.delete();
    }

    return response;
  }

  void verifyEmail() async {
    Timer.periodic(const Duration(seconds: 2), (timer) async {
      try {
        await FirebaseAuth.instance.currentUser!.reload();
      } catch (_) {}

      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        emit(EmailVerifyVerified());
        timer.cancel();
      }
    });
  }

  Future<void> resendVerficationLinkEmail() async {
    emit(EmailVerifyLoading());

    final res = await emailServices.sendVerficationLinkEmail();

      if (res == DataResponse.success) {
        emit(EmailResendSuccess());
      } else {
        emit(EmailResendFailure());
      }
  }

  @override
  void emit(EmailVerifyState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
