import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/constants/enums.dart';
import 'package:grocery_app/data/models/phone_model.dart';
import 'package:grocery_app/data/services/phone_services.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/helper/phone.dart';
import 'package:grocery_app/logic/info_cubit/info_cubit.dart';
import 'package:meta/meta.dart';
import 'package:phone_number/phone_number.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit({
    required this.infoCubit,
    required this.phone,
    required this.canSkip,
  }) : super(OtpInitial());

  final InfoCubit infoCubit;

  final bool canSkip;
  final PhoneServices phoneServices = PhoneServices();
  final TextEditingController pinputController = TextEditingController();
  final GlobalKey<FormFieldState> phoneFieldKey = GlobalKey();
  PhoneModel? phone;
  String? verificationPhoneId;
  String? phoneFieldErrorMessage;

  Future<void> sendOTP(BuildContext context) async {
    phone = await validatePhone(context);
    emit(OTPSendLoading());
    if (phone != null) {
      DataResponse? respnose;
      if (context.mounted) {
        respnose = await checkPhoneExists(context);
      }
      if (respnose == null || respnose == DataResponse.failure) {
        emit(OTPFailure());
        return;
      }
    }
    if (phoneFieldKey.currentState!.validate()) {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone!.e164,
        verificationCompleted: (phoneAuthCredential) {},
        verificationFailed: (FirebaseAuthException ex) {
          verificationFailed(context, ex);
        },
        codeSent: (verificationId, resendToken) {
          codeSent(
            verificationId: verificationId,
          );
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } else {
      emit(OtpInitial());
    }
  }

  Future<DataResponse> checkPhoneExists(BuildContext context) async {
    final response = await phoneServices.checkPhoneExists(phone!);

    if (response.state == DataResponse.success) {
      if (context.mounted) {
        phoneFieldErrorMessage =
            response.exists ? S.of(context).phoneVerifiedByAnthorUser : null;
      } else {
        phoneFieldErrorMessage = "Error";
      }
    }
    return response.state;
  }

  Future<PhoneModel?> validatePhone(BuildContext context) async {
    PhoneNumber? phoneNumber =
        await PhoneParser.parse(phone: phone!.e164, code: phone!.countryCode);

    if (phoneNumber == null) {
      if (context.mounted) {
        phoneFieldErrorMessage = S.of(context).enterValidPhone;
      } else {
        phoneFieldErrorMessage = "Error";
      }
      return null;
    } else {
      phoneFieldErrorMessage = null;
      return PhoneModel.fromPhoneNumberObject(phoneNumber);
    }
  }

  void codeSent({
    required String verificationId,
  }) {
    verificationPhoneId = verificationId;
    emit(OTPSent());
  }

  void verificationFailed(BuildContext context, FirebaseAuthException ex) {
    String? message;
    if (ex.code == "too-many-requests") {
      message = S.of(context).TooManyRequests;
    } else if (ex.code == "missing-client-identifier") {
      message = S.of(context).failedToVerifyRobote;
    }
    emit(OTPFailure(message: message));
  }

  Future<void> submitOTP({required String? otpCode}) async {
    if (otpCode == null || otpCode == "") {
      emit(OTPEmpty());
    } else {
      final phoneCredential = PhoneAuthProvider.credential(
          verificationId: verificationPhoneId!, smsCode: otpCode);

      linkPhoneNumber(phoneCredential: phoneCredential);
    }
  }

  Future<void> linkPhoneNumber(
      {required PhoneAuthCredential phoneCredential}) async {
    final currentUser = infoCubit.currentUser;
    emit(OTPSubmitLoading());
    try {
      await FirebaseAuth.instance.currentUser!
          .updatePhoneNumber(phoneCredential);
      await phoneServices.updatePhoneWithVerify(phone!);
      currentUser!.phone = phone!;
      currentUser.phoneVerified = true;
      emit(OTPCorrect());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == "invalid-verification-code") {
        emit(OTPWrong());
      } else {
        emit(OTPFailure(message: ex.message));
      }
    }
  }

  @override
  void emit(OtpState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
