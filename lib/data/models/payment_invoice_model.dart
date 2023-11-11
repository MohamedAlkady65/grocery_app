import 'package:grocery_app/data/models/user_model.dart';

class PaymentInvoiceModel {
  final String email;
  final String name;
  final String phone;
  final int priceInCent;

  PaymentInvoiceModel(
      {required this.email,
      required this.name,
      required this.phone,
      required this.priceInCent});

  factory PaymentInvoiceModel.fromUserModel(
      {required UserModel user, required int priceInCent}) {
    return PaymentInvoiceModel(
        email: user.email,
        name: user.username,
        phone: user.phone.e164,
        priceInCent: priceInCent);
  }
}
