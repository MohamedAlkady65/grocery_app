import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_app/constants/enums.dart';
import 'package:grocery_app/data/models/phone_model.dart';
import 'package:grocery_app/helper/collections.dart';

class PhoneServices{
    Future<void> updatePhoneWithVerify(PhoneModel phone) async {
    try {
      await Collections.users
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"phone": phone.toJson(), "phoneVerified": true});
    } catch (_) {}
  }

  Future<({bool exists, DataResponse state})> checkPhoneExists(PhoneModel phone) async {
    try {
      final snap = await Collections.users
          .where(Filter.and(Filter("phone", isEqualTo: phone.toJson()),
              Filter("phoneVerified", isEqualTo: true)))
          .get();

      if (snap.docs.isEmpty) {
        return (state: DataResponse.success, exists: false);
      } else {
        return (state: DataResponse.success, exists: true);
      }
    } catch (_) {
      return (state: DataResponse.failure, exists: false);
    }
  }
}