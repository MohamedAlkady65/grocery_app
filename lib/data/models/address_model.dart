import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/data/models/phone_model.dart';
import 'package:grocery_app/helper/countries.dart';
import 'package:intl/intl.dart';

class AddressModel {
  String? id;
  String name;
  String street;
  String countryCode;
  String city;
  String zip;
  PhoneModel phone;
  bool isExpanded = false;

  AddressModel(
      {this.id,
      required this.name,
      required this.street,
      required this.countryCode,
      required this.city,
      required this.zip,
      required this.phone});

  factory AddressModel.fromJson(
      {required Map<String, dynamic> data, String? id}) {
    return AddressModel(
        id: id,
        name: data['name'],
        street: data['street'],
        countryCode: data['country'],
        city: data['city'],
        zip: data['zip'],
        phone: PhoneModel.fromJson(data['phone']));
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'street': street,
      'country': countryCode,
      'city': city,
      'zip': zip,
      'phone': phone.toJson()
    };
  }

  String country(BuildContext context) {
    List<Map<String, String>> countiresList =
        Intl.getCurrentLocale() == 'ar' ? Counrties.arabic : Counrties.english;
    return countiresList.firstWhereOrNull(
            (element) => element['code'] == countryCode)?['name'] ??
        "";
  }
}
