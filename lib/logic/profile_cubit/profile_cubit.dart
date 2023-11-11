import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/constants/enums.dart';
import 'package:grocery_app/data/models/phone_model.dart';
import 'package:grocery_app/data/services/profile_services.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/helper/phone.dart';
import 'package:grocery_app/logic/info_cubit/info_cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:phone_number/phone_number.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.infoCubit) : super(ProfileInitial());
  final InfoCubit infoCubit;
  ProfileService profileService = ProfileService();
  String? phoneText;
  String? phoneErrorMessage;
  String? username;
  GlobalKey<FormState> formKey = GlobalKey();
  void updateInfo(BuildContext context) async {
    if (phoneText == null && username == null) {
      emit(ProfileUpdateInfoSuccess());
      return;
    }
    PhoneModel? phone;
    if (phoneText != null) {
      phone = await validatePhone(context);
    }

    int notValidFieldsCount = 0;
    if (formKey.currentState!.validate()) {
      emit(ProfileUpdateInfoLoading());
      Map<String, dynamic> data = {};
      if (phoneText != null) {
        data['phone'] = phone!.toJson();
      }
      if (username != null) {
        data['username'] = username;
      }
      final response = await profileService.updateInfo(data: data);

      if (response == DataResponse.success) {
        if (phoneText != null) {
          infoCubit.currentUser!.phone = phone!;
        }
        if (username != null) {
          infoCubit.currentUser!.username = username!;
        }
        emit(ProfileUpdateInfoSuccess());
      } else if (response == DataResponse.failure) {
        emit(ProfileUpdateInfoFailure());
      }
    } else {
      if (phoneText == "" || phone == null) {
        notValidFieldsCount++;
      }
      if (username == "") {
        notValidFieldsCount++;
      }
    }
    emit(ProfileUpdateInfoValidState(notValidFieldsCount));
  }

  Future<PhoneModel?> validatePhone(BuildContext context) async {
    PhoneNumber? phoneNumber = await PhoneParser.parse(
        phone: phoneText, code: infoCubit.ipInfo?.countryCode2);

    if (phoneNumber == null) {
      if (context.mounted) {
        phoneErrorMessage = S.of(context).enterValidPhone;
      } else {
        phoneErrorMessage = "Error";
      }
      return null;
    } else {
      phoneErrorMessage = null;
      return PhoneModel.fromPhoneNumberObject(phoneNumber);
    }
  }

  void uploadUserImage({required ImageSource source}) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source);
    if (picked == null) return;

    emit(UploadUserImageLoading());

    final imgUrl =
        await profileService.uploadUserImage(image: File(picked.path));

    if (imgUrl == null) {
      emit(UploadUserImageFailure());
    } else {
      infoCubit.currentUser!.imgUrl = imgUrl;
      emit(UploadUserImageSuccess());
    }
  }

  void signOut() async {
    emit(SignOutLoading());
    try {
      await FirebaseAuth.instance.signOut();

      infoCubit.currentUser = null;
      emit(SignOutSuccess());
    } catch (_) {
      emit(SignOutFailure());
    }
  }

  void updatePhoneNumber() {
    emit(ProfileUpdateInfoSuccess());
  }

  @override
  void emit(ProfileState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
