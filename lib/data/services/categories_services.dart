import 'package:grocery_app/constants/enums.dart';
import 'package:grocery_app/data/models/category_model.dart';
import 'package:grocery_app/helper/collections.dart';

class CategoriesServices {
  Future<({List<CategoryModel> data, DataResponse state})>
      getCategories() async {
    List<CategoryModel> data = [];
    try {
      final snap = await Collections.categories.orderBy('title').get();

      data = snap.docs.map<CategoryModel>((e) => e.data()).toList();
      return (state: DataResponse.success, data: data);
    } on Exception catch (_) {
      return (state: DataResponse.failure, data: data);
    }
  }
}
