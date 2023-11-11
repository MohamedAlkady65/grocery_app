import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:grocery_app/constants/enums.dart';
import 'package:grocery_app/helper/collections.dart';

class ProfileService {
  Future<DataResponse> updateInfo({required Map<String, dynamic> data}) async {
    if (data.isEmpty) {
      return DataResponse.success;
    }
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return DataResponse.failure;
    try {
      await Collections.users.doc(uid).update(data);
      return DataResponse.success;
    } catch (_) {
      return DataResponse.failure;
    }
  }

  Future<String?> uploadUserImage({required File image}) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return null;
    final uploadImage = FirebaseStorage.instance.ref("users").child(uid);
    try {
      await uploadImage.putFile(image);
      return await updateUserImageInFireStore(uploadImage);
    } on Exception catch (_) {
      return null;
    }
  }

  Future<String?> updateUserImageInFireStore(Reference uploadImage) async {
    try {
      final imgUrl = await uploadImage.getDownloadURL();
      await Collections.users
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"imgUrl": imgUrl});
      return imgUrl;
    } catch (_) {
      uploadImage.delete();
      return "";
    }
  }
}
