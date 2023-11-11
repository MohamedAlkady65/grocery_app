import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_app/constants/enums.dart';

class ChangePasswordServices {
  Future<ChangePasswordResponse> changePassword(
      {required String currentPassword, required String newPassword}) async {
    String? email = FirebaseAuth.instance.currentUser?.email;
    if (email == null) {
      return ChangePasswordResponse.failure;
    }

    try {
      final cred =
          EmailAuthProvider.credential(email: email, password: currentPassword);
      final userCred = await FirebaseAuth.instance.currentUser!
          .reauthenticateWithCredential(cred);

      if (userCred.user == null) {
        return ChangePasswordResponse.failure;
      }
      await userCred.user!.updatePassword(newPassword);

      return ChangePasswordResponse.success;
    } on FirebaseAuthException catch (e) {
      if (e.code == "wrong-password") {
        return ChangePasswordResponse.wrongCurrentPassword;
      } else if (e.code == "weak-password") {
        return ChangePasswordResponse.weakNewPassword;
      } else {
        return ChangePasswordResponse.failure;
      }
    } catch (_) {
      return ChangePasswordResponse.failure;
    }
  }
}
