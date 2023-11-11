import 'package:grocery_app/constants/const.dart';
import 'package:grocery_app/data/models/payment_invoice_model.dart';
import 'package:grocery_app/helper/dio_helper.dart';

class PaymentServices {
  PaymentServices({required PaymentInvoiceModel paymentInvoice})
      : _paymentInvoice = paymentInvoice,
        _dio = DioHelper(baseUrl: kPaymobBaseUrl),
        _integrationId = 4143130;

  final DioHelper _dio;
  final PaymentInvoiceModel _paymentInvoice;
  final int _integrationId;
  String? _authToken;
  int? _orderId;
  String? _paymentToken;

  Future<void> getAuthToken() async {
    final response = await _dio
        .post(url: kPaymobAuthRequestUrl, data: {"api_key": kPaymobApiKey});

    _authToken = response.data['token'];
  }

  Future<void> getOrderId() async {
    final response = await _dio.post(url: kPaymobOrderRequestUrl, data: {
      "auth_token": _authToken,
      "delivery_needed": "false",
      "amount_cents": _paymentInvoice.priceInCent,
      "currency": "EGP",
      "items": []
    });

    _orderId = response.data['id'];
  }

  Future<void> getPaymentToken() async {
    final response = await _dio.post(url: kPaymobPaymentKeyRequestUrl, data: {
      "auth_token": _authToken,
      "order_id": _orderId,
      "amount_cents": _paymentInvoice.priceInCent,
      "currency": "EGP",
      "integration_id": _integrationId,
      "expiration": 3600,
      "billing_data": {
        "email": _paymentInvoice.email,
        "first_name": _paymentInvoice.name,
        "last_name": "N",
        "phone_number": _paymentInvoice.phone,
        "apartment": "NA",
        "floor": "NA",
        "street": "NA",
        "building": "NA",
        "shipping_method": "NA",
        "postal_code": "NA",
        "city": "NA",
        "country": "NA",
        "state": "NA"
      }
    });
    _paymentToken = response.data['token'];
  }

  Future<String> createPaymentToken() async {
    await getAuthToken();
    await getOrderId();
    await getPaymentToken();
    return _paymentToken!;
  }
}
