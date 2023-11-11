import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_app/constants/enums.dart';
import 'package:grocery_app/data/models/address_model.dart';
import 'package:grocery_app/helper/collections.dart';

class AddressesServices {
  Future<DataResponse> add({required AddressModel address}) async {
    if (FirebaseAuth.instance.currentUser == null) {
      return DataResponse.failure;
    }
    try {
    final doc =  await Collections.addressesCol.add(address);
      address.id = doc.id;

      return DataResponse.success;
    } catch (_) {
      return DataResponse.failure;
    }
  }

  Future<DataResponse> setDefault(String? addressId) async {
    try {
      await Collections.addresses.set(
          {"default": addressId ?? FieldValue.delete()},
          SetOptions(merge: true));

      return DataResponse.success;
    } catch (_) {
      return DataResponse.failure;
    }
  }

  Future<DataResponse> removeAddress({required String addressId}) async {
    if (FirebaseAuth.instance.currentUser == null) {
      return DataResponse.failure;
    }
    try {
      await Collections.addressesCol.doc(addressId).delete();
      return DataResponse.success;
    } catch (_) {
      return DataResponse.failure;
    }
  }

  Future<DataResponse> editAddress(
      {required String addressId, required Map<String, dynamic> data}) async {
    if (data.isEmpty) return DataResponse.success;
    if (FirebaseAuth.instance.currentUser == null) {
      return DataResponse.failure;
    }
    try {
      await Collections.addressesCol.doc(addressId).update(data);
      return DataResponse.success;
    } catch (_) {
      return DataResponse.failure;
    }
  }

  Future<
      ({
        List<AddressModel> data,
        DataResponse state,
        String? defaultAddressId
      })> getAddresses() async {
    if (FirebaseAuth.instance.currentUser == null) {
      return (
        state: DataResponse.failure,
        data: <AddressModel>[],
        defaultAddressId: null
      );
    }
    try {
      final snapshot = await Collections.addressesCol.get();

      final snapshotForDefault = await Collections.addresses.get();

      List<AddressModel> data = snapshot.docs
          .map<AddressModel>(
            (e) => e.data(),
          )
          .toList();

      return (
        state: DataResponse.success,
        data: data,
        defaultAddressId: snapshotForDefault.data()?['default'] as String?
      );
    } catch (_) {
      return (
        state: DataResponse.failure,
        data: <AddressModel>[],
        defaultAddressId: null
      );
    }
  }
}
