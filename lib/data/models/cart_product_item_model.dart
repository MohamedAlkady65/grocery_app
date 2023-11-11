import 'package:cloud_firestore/cloud_firestore.dart';

class CartProductItemModel {
  final String productId;
  int count;

  CartProductItemModel({required this.productId, required this.count});

  Map<String, dynamic> toJson() {
    return {'count': count, "date": FieldValue.serverTimestamp()};
  }
}
