import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_app/constants/enums.dart';
import 'package:grocery_app/data/models/product_model.dart';
import 'package:grocery_app/helper/collections.dart';
import 'package:grocery_app/logic/products_cubit/products_cubit.dart';

class ProductsServices {
  Future<({List<ProductModel> data, DataResponse state})> getFeaturedProducts(
      {required ProductsCubit productsCubit}) async {
    List<ProductModel> data = [];
    if (FirebaseAuth.instance.currentUser == null) {
      return (state: DataResponse.failure, data: data);
    }

    try {
      final snap = await Collections.products.orderBy('title').get();

      data = snap.docs.map<ProductModel>((e) => e.data()).toList();
      await fillFavorites(productsCubit);
      await fillCart(productsCubit);
      return (state: DataResponse.success, data: data);
    } on Exception catch (_) {
      return (state: DataResponse.failure, data: data);
    }
  }

  Future<({List<ProductModel> data, DataResponse state})>
      getFeaturedAtHomeProducts({required ProductsCubit productsCubit}) async {
    List<ProductModel> data = [];
    if (FirebaseAuth.instance.currentUser == null) {
      return (state: DataResponse.failure, data: data);
    }

    try {
      final snap = await Collections.products.orderBy('title').get();

      data = snap.docs.map<ProductModel>((e) => e.data()).toList();
      await fillFavorites(productsCubit);
      await fillCart(productsCubit);
      return (state: DataResponse.success, data: data);
    } on Exception catch (_) {
      return (state: DataResponse.failure, data: data);
    }
  }

  Future<({List<ProductModel> data, DataResponse state})> getProductsOfCategory(
      {required String categoryId, required ProductsCubit productsCubit}) async {
    List<ProductModel> data = [];
    if (FirebaseAuth.instance.currentUser == null) {
      return (state: DataResponse.failure, data: data);
    }
    try {
      final snap = await Collections.products
          .where('categoryId', isEqualTo: categoryId)
          .orderBy('title')
          .get();

      data = snap.docs.map<ProductModel>((e) => e.data()).toList();
      await fillFavorites(productsCubit);
      await fillCart(productsCubit);
      return (state: DataResponse.success, data: data);
    } on Exception catch (_) {
      return (state: DataResponse.failure, data: data);
    }
  }

  Future<void> fillCart(ProductsCubit productsCubit) async {
    final cartSnapshot = await Collections.cart.get();
    productsCubit.cartItems = cartSnapshot.docs.map((e) => e.data()).toList();
  }

  Future<void> fillFavorites(ProductsCubit productsCubit) async {
    final favoritesSnapshot = await Collections.favoraites.get();
    productsCubit.favoriteProducts =
        favoritesSnapshot.docs.map((e) => e.id).toList();
  }
}
