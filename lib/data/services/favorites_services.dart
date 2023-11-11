import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_app/constants/enums.dart';
import 'package:grocery_app/data/models/product_model.dart';
import 'package:grocery_app/helper/collections.dart';

class FavoritesServices {
  Future<({List<ProductModel> data, DataResponse state})>
      getFavoritesProducts() async {
    List<ProductModel> data = [];
    if (FirebaseAuth.instance.currentUser == null) {
      return (state: DataResponse.failure, data: data);
    }
    try {
      final snapshot = await Collections.favoraites.orderBy("date").get();

      if (snapshot.docs.isEmpty) {
        return (state: DataResponse.success, data: data);
      }

      List<String> favoritesIdList = snapshot.docs.map((e) => e.id).toList();

      final snap = await Collections.products
          .where(FieldPath.documentId, whereIn: favoritesIdList)
          .get();

      Map<String, ProductModel> products = {};
      for (var pro in snap.docs) {
        products[pro.id] = pro.data();
      }

      for (var proId in favoritesIdList) {
        ProductModel? product = products[proId];
        if (product == null) {
          break;
        }
        data.add(product);
      }

      return (state: DataResponse.success, data: data);
    } on Exception catch (_) {
      return (state: DataResponse.failure, data: data);
    }
  }

  Future<DataResponse> changeFavorite(
      {required String productId, required bool newState}) async {
    try {
      if (newState) {
        await Collections.favoraites
            .doc(productId)
            .set({"date": FieldValue.serverTimestamp()});
      } else {
        await Collections.favoraites.doc(productId).delete();
      }

      return DataResponse.success;
    } catch (_) {
      return DataResponse.failure;
    }
  }

  Future<DataResponse> clearfavorites(List<ProductModel> favorites) async {
    final batch = FirebaseFirestore.instance.batch();

    for (var item in favorites) {
      batch.delete(Collections.favoraites.doc(item.id));
    }

    try {
      await batch.commit();

      return DataResponse.success;
    } catch (_) {
      return DataResponse.failure;
    }
  }
}
