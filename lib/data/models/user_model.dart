import 'package:grocery_app/data/models/phone_model.dart';

class UserModel {
  final String id;
  final String email;
  String username;
  PhoneModel phone;
  bool phoneVerified;
  String? imgUrl;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.phoneVerified,
    this.imgUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> data, String id) {
    return UserModel(
      id: id,
      username: data['username'],
      email: data['email'],
      phone: PhoneModel.fromJson(data['phone']),
      phoneVerified: data['phoneVerified'],
      imgUrl: data['imgUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "email": email,
      "phone": phone.toJson(),
      "phoneVerified": phoneVerified
    };
  }

  @override
  String toString() {
    return id;
  }
}
