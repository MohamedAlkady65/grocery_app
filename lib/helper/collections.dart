import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_app/data/models/address_model.dart';
import 'package:grocery_app/data/models/cart_product_item_model.dart';
import 'package:grocery_app/data/models/category_model.dart';
import 'package:grocery_app/data/models/landing_item_model.dart';
import 'package:grocery_app/data/models/order_item_model.dart';
import 'package:grocery_app/data/models/order_model.dart';
import 'package:grocery_app/data/models/product_model.dart';
import 'package:grocery_app/data/models/review_model.dart';
import 'package:grocery_app/data/models/user_model.dart';

class Collections {
  static CollectionReference<UserModel> get users =>
      FirebaseFirestore.instance.collection("users").withConverter<UserModel>(
            fromFirestore: (snapshot, options) =>
                UserModel.fromJson(snapshot.data()!, snapshot.id),
            toFirestore: (user, options) => user.toJson(),
          );

  static CollectionReference<ProductModel> get products =>
      FirebaseFirestore.instance
          .collection("products")
          .withConverter<ProductModel>(
            fromFirestore: (snapshot, options) =>
                ProductModel.fromJson(data: snapshot.data()!, uid: snapshot.id),
            toFirestore: (product, options) => product.toJson(),
          );

  static CollectionReference<CategoryModel> get categories => FirebaseFirestore
      .instance
      .collection("categories")
      .withConverter<CategoryModel>(
        fromFirestore: (snapshot, options) =>
            CategoryModel.fromJson(data: snapshot.data()!, uid: snapshot.id),
        toFirestore: (category, options) => category.toJson(),
      );

  static CollectionReference<Map<String, dynamic>> get favoraites =>
      FirebaseFirestore.instance
          .collection("allFavoraites")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("favoraites");

  // static DocumentReference<Map<String, dynamic>> get cartDoc =>
  //     FirebaseFirestore.instance
  //         .collection("allCarts")
  //         .doc(FirebaseAuth.instance.currentUser!.uid);

  static CollectionReference<CartProductItemModel> get cart =>
      FirebaseFirestore.instance
          .collection("allCarts")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("cart")
          .withConverter<CartProductItemModel>(
            fromFirestore: (snapshot, options) => CartProductItemModel(
                productId: snapshot.id, count: snapshot.data()!['count']),
            toFirestore: (value, options) => value.toJson(),
          );

  static CollectionReference<ReviewModel> reviews(
          {required String productId}) =>
      FirebaseFirestore.instance
          .collection("allReviews")
          .doc(productId)
          .collection("reviewsOfProduct")
          .withConverter<ReviewModel>(
            fromFirestore: (snapshot, options) =>
                ReviewModel.fromJson(data: snapshot.data()!),
            toFirestore: (review, options) => review.toJson(),
          );

  static CollectionReference<AddressModel> get addressesCol =>
      FirebaseFirestore.instance
          .collection("allAddresses")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("addresses")
          .withConverter<AddressModel>(
            fromFirestore: (snapshot, options) =>
                AddressModel.fromJson(data: snapshot.data()!, id: snapshot.id),
            toFirestore: (address, options) => address.toJson(),
          );

  static DocumentReference<Map<String, dynamic>> get addresses =>
      FirebaseFirestore.instance
          .collection("allAddresses")
          .doc(FirebaseAuth.instance.currentUser!.uid);

  static Query<OrderModel> get ordersOfUser => FirebaseFirestore.instance
      .collection("orders")
      .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .withConverter<OrderModel>(
        fromFirestore: (snapshot, options) =>
            OrderModel.fromJson(data: snapshot.data()!, id: snapshot.id),
        toFirestore: (address, options) => address.toJson(),
      );

  static CollectionReference<OrderModel> get orders =>
      FirebaseFirestore.instance.collection("orders").withConverter<OrderModel>(
            fromFirestore: (snapshot, options) =>
                OrderModel.fromJson(data: snapshot.data()!, id: snapshot.id),
            toFirestore: (address, options) =>
                address.toJson(userId: FirebaseAuth.instance.currentUser!.uid),
          );

  static CollectionReference<OrderItemModel> orderItems(String orderId) =>
      FirebaseFirestore.instance
          .collection("orders")
          .doc(orderId)
          .collection("orderItems")
          .withConverter<OrderItemModel>(
            fromFirestore: (snapshot, options) =>
                OrderItemModel.fromJson(data: snapshot.data()!),
            toFirestore: (address, options) => address.toJson(),
          );

  static CollectionReference<LandingItemModel> get landing =>
      FirebaseFirestore.instance
          .collection("landing")
          .withConverter<LandingItemModel>(
            fromFirestore: (snapshot, options) =>
                LandingItemModel.formJson(snapshot.data()!),
            toFirestore: (value, options) => value.toJson(),
          );
}
