import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_app/constants/enums.dart';
import 'package:grocery_app/data/models/user_model.dart';
import 'package:grocery_app/helper/collections.dart';

class SignInService {
  Future<({SingInResponse state, UserModel? user})> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential cred =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = await getUserFromFireStore(uid: cred.user!.uid);
      if (user == null) {
        return (state: SingInResponse.failure, user: null);
      }
      return (state: SingInResponse.success, user: user);
    } on FirebaseAuthException catch (e) {
      if (['wrong-password', 'invalid-email', 'user-not-found']
          .contains(e.code)) {
        return (state: SingInResponse.wrong, user: null);
      } else {
        return (state: SingInResponse.failure, user: null);
      }
    } catch (ex) {
      return (state: SingInResponse.failure, user: null);
    }
  }

  Future<UserModel?> getUserFromFireStore({required String uid}) async {
    try {
      final doc = await Collections.users.doc(uid).get();
      return doc.data();
    } on Exception catch (_) {
      return null;
    }
  }
}
