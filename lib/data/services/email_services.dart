import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_app/constants/enums.dart';

class EmailServices {
  Future<DataResponse> sendVerficationLinkEmail() async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      return DataResponse.success;
    } catch (ex) {
      return DataResponse.failure;
    }
  }
}
