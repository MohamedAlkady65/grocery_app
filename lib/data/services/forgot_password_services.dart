import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_app/constants/enums.dart';

class ForgotPasswordServices {
  Future<ForgotPasswordResponse> sendResetLink({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return ForgotPasswordResponse.success;
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        return ForgotPasswordResponse.invalidEmail;
      } else if (e.code == "user-not-found") {
        return ForgotPasswordResponse.userNotFound;
      } else {
        return ForgotPasswordResponse.failure;
      }
    } catch (_) {
      return ForgotPasswordResponse.failure;
    }
  }
}
