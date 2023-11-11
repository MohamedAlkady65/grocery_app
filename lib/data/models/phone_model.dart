import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/logic/info_cubit/info_cubit.dart';
import 'package:phone_number/phone_number.dart';

class PhoneModel {
  final String? national;
  final String? international;
  final String countryCode;
  final String e164;

  PhoneModel(
      {this.national,
      this.international,
      required this.countryCode,
      required this.e164});

  factory PhoneModel.fromJson(Map<String, dynamic> data) {
    return PhoneModel(
        national: data['national'],
        international: data['international'],
        countryCode: data['countryCode'],
        e164: data['e164']);
  }

  factory PhoneModel.fromPhoneNumberObject(PhoneNumber phoneNumber) {
    return PhoneModel(
        national: phoneNumber.national,
        countryCode: phoneNumber.regionCode,
        international: phoneNumber.international,
        e164: phoneNumber.e164);
  }

  Map<String, dynamic> toJson() {
    return {
      'national': national!,
      'international': international!,
      'countryCode': countryCode,
      'e164': e164
    };
  }

  String getPhoneText({required BuildContext context}) {
    final countryCode =
        BlocProvider.of<InfoCubit>(context).ipInfo?.countryCode2;
    return countryCode == this.countryCode ? national! : international!;
  }

  @override
  String toString() {
    return "e164 => $e164, countryCode => $countryCode,  natinal=> $national , international => $international";
  }
}
