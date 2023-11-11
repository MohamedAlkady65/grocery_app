import 'package:grocery_app/data/models/product_model.dart';

class OrderItemModel {
  ProductModel? product;
  final String productId;
  final String title;
  final double price;
  final String quantity;
  final String imgUrl;
  final int count;

  OrderItemModel({
    required this.productId,
    required this.title,
    required this.price,
    required this.quantity,
    required this.imgUrl,
    required this.count,
  });

  factory OrderItemModel.fromJson({required Map<String, dynamic> data}) {
    return OrderItemModel(
      productId: data['productId'],
      title: data['title'],
      price: data['price'],
      quantity: data['quantity'],
      imgUrl: data['imageUrl'],
      count: data['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'title': title,
      'price': price,
      'quantity': quantity,
      'imageUrl': imgUrl,
      'count': count,
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return product.toString();
  }
}
