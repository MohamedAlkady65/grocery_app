import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_app/constants/enums.dart';
import 'package:grocery_app/data/models/phone_model.dart';
import 'package:grocery_app/data/models/user_model.dart';
import 'package:grocery_app/helper/collections.dart';

class SignUpService {
  Future<({SingUpResponse response, UserModel? userInfo})> signUp({
    required String email,
    required String username,
    required PhoneModel phone,
    required String password,
  }) async {
    try {
      final UserCredential cred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final UserModel userInfo = UserModel(
          username: username,
          email: email,
          phone: phone,
          phoneVerified: false,
          id: cred.user!.uid);

      final bool res =
          await saveUserToFireStore(userInfo: userInfo, uid: cred.user!.uid);

      if (!res) {
        cred.user!.delete();
        return (response: SingUpResponse.failure, userInfo: null);
      }

      return (response: SingUpResponse.success, userInfo: userInfo);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return (response: SingUpResponse.weakPassword, userInfo: null);
      } else if (e.code == 'email-already-in-use') {
        return (response: SingUpResponse.emailAlreadyUsed, userInfo: null);
      } else if (e.code == 'invalid-email') {
        return (response: SingUpResponse.invalidEmail, userInfo: null);
      } else {
        return (response: SingUpResponse.failure, userInfo: null);
      }
    } catch (ex) {
      return (response: SingUpResponse.failure, userInfo: null);
    }
  }

  Future<bool> saveUserToFireStore(
      {required UserModel userInfo, required String uid}) async {
    try {
      await Collections.users.doc(uid).set(userInfo);
      return true;
    } on Exception catch (_) {
      return false;
    }
  }





}
