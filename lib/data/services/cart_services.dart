import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_app/constants/enums.dart';
import 'package:grocery_app/data/models/cart_item_model.dart';
import 'package:grocery_app/data/models/cart_product_item_model.dart';
import 'package:grocery_app/data/models/product_model.dart';
import 'package:grocery_app/helper/collections.dart';

class CartServices {
  Future<({List<CartItemModel> data, DataResponse state})>
      getCartItems() async {
    List<CartItemModel> data = [];
    if (FirebaseAuth.instance.currentUser == null) {
      return (state: DataResponse.failure, data: data);
    }
    try {
      final snapshot = await Collections.cart.orderBy("date").get();

      if (snapshot.docs.isEmpty) {
        return (state: DataResponse.success, data: data);
      }

      List<String> cartItemsIdList = snapshot.docs.map((e) => e.id).toList();

      final snap = await Collections.products
          .where(FieldPath.documentId, whereIn: cartItemsIdList)
          .get();

      Map<String, ProductModel> products = {};
      for (var pro in snap.docs) {
        products[pro.id] = pro.data();
      }

      for (int i = 0; i < cartItemsIdList.length; i++) {
        ProductModel? product = products[snapshot.docs[i].id];
        if (product == null) {
          break;
        }
        int count = snapshot.docs[i].data().count;
        data.add(CartItemModel(product: product, count: count));
      }
      return (state: DataResponse.success, data: data);
    } on Exception catch (_) {
      return (state: DataResponse.failure, data: data);
    }
  }

  Future<DataResponse> changeCartItemCount(
      {required String productId,
      required int newValue,
      required bool isNew}) async {
    try {
      if (newValue == 0) {
        await Collections.cart.doc(productId).delete();
      } else {
        if (isNew) {
          await Collections.cart
              .doc(productId)
              .set(CartProductItemModel(productId: productId, count: newValue));
        } else {
          await Collections.cart.doc(productId).update({'count': newValue});
        }
      }
      return DataResponse.success;
    } catch (_) {
      return DataResponse.failure;
    }
  }

  Future<DataResponse> clearCart(List<CartItemModel> cartItems) async {
    final batch = FirebaseFirestore.instance.batch();

    for (var item in cartItems) {
      batch.delete(Collections.cart.doc(item.product.id));
    }

    try {
      await batch.commit();

      return DataResponse.success;
    } catch (_) {
      return DataResponse.failure;
    }
  }
}
