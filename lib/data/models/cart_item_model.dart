import 'package:grocery_app/data/models/product_model.dart';

class CartItemModel {
  final ProductModel product;
  int count;

  CartItemModel({required this.product, required this.count});
}
