import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String comment;
  final double rate;
  final String userId;
  final String productId;
  final DateTime date;
  String? username;
  String? userImgUrl;

  ReviewModel(
      {this.username,
      this.userImgUrl,
      required this.date,
      required this.comment,
      required this.rate,
      required this.userId,
      required this.productId});

  factory ReviewModel.fromJson({required Map<String, dynamic> data}) {
    return ReviewModel(
        username: data['username'],
        userImgUrl: data['userImgUrl'],
        date: DateTime.fromMillisecondsSinceEpoch(
            data['date'].millisecondsSinceEpoch,
            isUtc: true),
        comment: data['comment'],
        rate: data['rate'],
        userId: data['userId'],
        productId: data['productId']);
  }

  Map<String, dynamic> toJson() {
    return {
      'comment': comment,
      'rate': rate,
      'userId': userId,
      'date': FieldValue.serverTimestamp(),
      'productId': productId
    };
  }

  @override
  String toString() {
    return userId.toString();
  }
}
