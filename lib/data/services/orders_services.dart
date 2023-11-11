import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_app/constants/enums.dart';
import 'package:grocery_app/data/models/order_item_model.dart';
import 'package:grocery_app/data/models/order_model.dart';
import 'package:grocery_app/data/models/product_model.dart';
import 'package:grocery_app/helper/collections.dart';

class OrdersServices {
  Future<DataResponse> makeOrder(
      {required OrderModel order,
      required List<OrderItemModel> orderItems}) async {
    if (FirebaseAuth.instance.currentUser == null) return DataResponse.failure;

    try {
      await Collections.orders.doc(order.id).set(order);
      await Future.wait(orderItems.map((e) {
        return Collections.orderItems(order.id).add(e);
      }));
      return DataResponse.success;
    } catch (_) {
      return DataResponse.failure;
    }
  }

  Future<({List<OrderModel> orders, DataResponse state})> getOrders() async {
    if (FirebaseAuth.instance.currentUser == null) {
      return (state: DataResponse.failure, orders: <OrderModel>[]);
    }

    try {
      final snapshot =
          await Collections.orders.orderBy("step0", descending: true).get();

      List<OrderModel> orders = snapshot.docs.map((e) => e.data()).toList();

      return (state: DataResponse.success, orders: orders);
    } catch (_) {
      return (state: DataResponse.failure, orders: <OrderModel>[]);
    }
  }

  Future<({List<OrderItemModel> orderItems, DataResponse state})> getOrderItems(
      String orderId) async {
    try {
      final snapshot = await Collections.orderItems(orderId).get();

      Map<String, ProductModel> productsMap = await getProductsMap(snapshot);

      List<OrderItemModel> orderItems = snapshot.docs
          .map((e) => e.data()..product = productsMap[e.data().productId])
          .toList();

      return (state: DataResponse.success, orderItems: orderItems);
    } catch (_) {
      return (state: DataResponse.failure, orderItems: <OrderItemModel>[]);
    }
  }

  Future<Map<String, ProductModel>> getProductsMap(
      QuerySnapshot<OrderItemModel> snapshot) async {
    List<String> productsId =
        snapshot.docs.map((e) => e.data().productId).toList();

    final productsSnapShot = await Collections.products
        .where(FieldPath.documentId, whereIn: productsId)
        .get();

    Map<String, ProductModel> productsMap = {};
    for (var pro in productsSnapShot.docs) {
      productsMap[pro.id] = pro.data();
    }
    return productsMap;
  }

  Future<bool> checkOrderIdExists(String orderId) async {
    bool? exists;
    await Collections.orders.doc(orderId).get().then((value) {
      exists = value.exists;
    }).catchError((error) {});

    return exists ?? false;
  }
}
