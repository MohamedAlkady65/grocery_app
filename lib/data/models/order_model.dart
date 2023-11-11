import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/constants/enums.dart';
import 'package:grocery_app/data/models/address_model.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/generated/l10n.dart';

class OrderModel {
  late final String id;
  late final double totalPrice;
  late final int itemsCount;
  late final PaymentMethod paymentMethod;
  late final List<DateTime?> steps;

  late final AddressModel address;
  String? transactionId;

  OrderModel({
    required this.id,
    required this.totalPrice,
    required this.itemsCount,
    required this.address,
    required this.paymentMethod,
    required this.transactionId,
    required this.steps,
  });

  OrderModel.fromJson({required Map<String, dynamic> data, required this.id}) {
    totalPrice = data['totalPrice'];
    itemsCount = data['itemsCount'];

    paymentMethod = data['paymentMethod'] == 1
        ? PaymentMethod.cash
        : PaymentMethod.creditCard;

    transactionId = data['transactionId'];

    steps = [
      getUTCDate(data['step0'].toDate())!,
      getUTCDate(data['step1']?.toDate()),
      getUTCDate(data['step2']?.toDate()),
      getUTCDate(data['step3']?.toDate()),
      getUTCDate(data['step4']?.toDate())
    ];

    steps.removeWhere((element) => element == null);

    address =
        AddressModel.fromJson(data: data['address'], id: data['address']['id']);
  }

  DateTime? getUTCDate(DateTime? date) {
    if (date == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(date.millisecondsSinceEpoch,
        isUtc: true);
  }

  String paymentMethodString(BuildContext context) =>
      paymentMethod == PaymentMethod.cash
          ? S.of(context).cash
          : S.of(context).creditCard;

  Map<String, dynamic> toJson({String? userId}) {
    return {
      'userId': userId!,
      'totalPrice': totalPrice,
      'itemsCount': itemsCount,
      'paymentMethod': paymentMethod == PaymentMethod.cash ? 1 : 2,
      'transactionId': transactionId,
      'step0': FieldValue.serverTimestamp(),
      'address': address.toJson()..addAll({"id": address.id})
    };
  }
}
