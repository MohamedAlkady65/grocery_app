import 'package:flutter/material.dart';
import 'package:grocery_app/data/models/category_model.dart';
import 'package:grocery_app/presentation/components/cart_floation_action_button.dart';
import 'package:grocery_app/presentation/components/check_connection.dart';
import 'package:grocery_app/presentation/components/custom_app_bar.dart';
import 'package:grocery_app/presentation/components/filter_icon_button.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/presentation/products/widgets/products_category_body.dart';

class ProductsCategoryScreen extends StatelessWidget {
  const ProductsCategoryScreen({super.key});
  static const String id = "ProductsCategoryScreen";
  @override
  Widget build(BuildContext context) {
    late CategoryModel category;
    category = ModalRoute.of(context)!.settings.arguments as CategoryModel;

    return Scaffold(
        backgroundColor: MyColors.backgroundSecondry,
        floatingActionButton: const CartFloatingActionButton(),
        appBar: CustomAppBar(
          title: category.title,
          actions: const [FilterIconButton()],
        ),
        body: CheckConnection(
            child: ProductsCategoryBody(
          categoryId: category.id,
        )));
  }
}
