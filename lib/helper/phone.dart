import 'package:phone_number/phone_number.dart';

class PhoneParser {
  static Future<PhoneNumber?> parse(
      {required String? phone, String? code}) async {
    if (phone == null || phone == "" || phone.length < 5) {
      return null;
    }

    try {
      bool validateWithOutCode = await PhoneNumberUtil().validate(phone);
      if (validateWithOutCode) {
        return await PhoneNumberUtil().parse(phone);
      }
    } catch (_) {}

    if (code == null) {
      return null;
    }

    try {
      bool validateWithCode =
          await PhoneNumberUtil().validate(phone, regionCode: code);

      if (validateWithCode) {
        return await PhoneNumberUtil().parse(phone, regionCode: code);
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }
}
