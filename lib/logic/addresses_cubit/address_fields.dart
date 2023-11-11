import 'package:flutter/material.dart';
import 'package:grocery_app/data/models/phone_model.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/helper/phone.dart';
import 'package:grocery_app/logic/info_cubit/info_cubit.dart';
import 'package:phone_number/phone_number.dart';

class AddressData {
  String name = "";
  String street = "";
  String countryCode = "";
  String city = "";
  String zip = "";
  String phoneText = "";
  PhoneModel? phone;
  bool isDefault = false;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'street': street,
      'country': countryCode,
      'city': city,
      'zip': zip,
      'phone': phone!.toJson()
    };
  }

  void clear() {
    name = street = countryCode = city = zip = phoneText = "";
    isDefault = false;
  }
}

class EditAddressData {
  String? id;
  String? name;
  String? street;
  String? country;
  String? city;
  String? zip;
  String? phoneText;
  PhoneModel? phone;
  String? phoneErrorMessage;
  bool? isDefault;

  void editName({required String addressId, required String value}) {
    if (addressId != id) {
      clear();
    }

    id = addressId;

    name = value;
  }

  void editStreet({required String addressId, required String value}) {
    if (addressId != id) {
      clear();
    }
    id = addressId;

    street = value;
  }

  void editCountry({required String addressId, required String value}) {
    if (addressId != id) {
      clear();
    }
    id = addressId;

    country = value;
  }

  void editCity({required String addressId, required String value}) {
    if (addressId != id) {
      clear();
    }
    id = addressId;

    city = value;
  }

  void editZip({required String addressId, required String value}) {
    if (addressId != id) {
      clear();
    }
    id = addressId;

    zip = value;
  }

  void editPhone({required String addressId, required String value}) {
    if (addressId != id) {
      clear();
    }
    id = addressId;

    phoneText = value;
  }

  void editDefault({required String addressId, required bool value}) {
    if (addressId != id) {
      clear();
    }
    id = addressId;

    isDefault = value;
  }

  Future<void> validatePhone(BuildContext context, InfoCubit infoCubit) async {
    if (phoneText == null) return;
    final countryCode = infoCubit.ipInfo?.countryCode2;
    PhoneNumber? phoneNumber =
        await PhoneParser.parse(phone: phoneText, code: countryCode);

    if (phoneNumber == null) {
      if (context.mounted) {
        phoneErrorMessage = S.of(context).enterValidPhone;
      } else {
        phoneErrorMessage = "Error";
      }
    } else {
      phoneErrorMessage = null;
      phone = PhoneModel.fromPhoneNumberObject(phoneNumber);
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};

    if (name != null) {
      map.addAll({"name": name});
    }
    if (street != null) {
      map.addAll({"street": street});
    }
    if (country != null) {
      map.addAll({"country": country});
    }
    if (city != null) {
      map.addAll({"city": city});
    }
    if (zip != null) {
      map.addAll({"zip": zip});
    }
    if (phoneText != null) {
      map.addAll({"phone": phone!.toJson()});
    }

    return map;
  }

  void clear() {
    id = name = street = country =
        city = zip = phoneText = phone = phoneErrorMessage = isDefault = null;
  }
}
