class ProductModel {
  final String id;
  final String title;
  final double price;
  final String quantity;
  final String categoryId;
  final String description;
  final List<ImageProduct> images;
  int reviewsCount;
  double rate;

  ProductModel(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.quantity,
      required this.categoryId,
      required this.images,
      required this.rate,
      required this.reviewsCount});

  factory ProductModel.fromJson(
      {required Map<String, dynamic> data, required String uid}) {
    List<dynamic> imagesJson = data['images'];
    List<ImageProduct> images = imagesJson
        .map<ImageProduct>(
          (img) => ImageProduct.fromJson(img),
        )
        .toList();

    return ProductModel(
        id: uid,
        title: data['title'],
        price: data['price'],
        description: data['description'],
        quantity: data['quantity'],
        categoryId: data['categoryId'],
        reviewsCount: data['reviewsCount'] ?? 0,
        rate: data['rate'] ?? 0.0,
        images: images);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> imagesJson =
        images.map<Map<String, dynamic>>((img) => img.toJson()).toList();
    return {
      'title': title,
      'price': price,
      'description': description,
      'quantity': quantity,
      'categoryId': categoryId,
      'images': imagesJson
    };
  }

}

class ImageProduct {
  final String imgUrl;
  final bool isDefault;

  ImageProduct({
    required this.imgUrl,
    required this.isDefault,
  });

  factory ImageProduct.fromJson(Map<String, dynamic> data) {
    return ImageProduct(
      imgUrl: data['imgUrl'],
      isDefault: data['isDefault'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'imgUrl': imgUrl, 'isDefault': isDefault};
  }
}
