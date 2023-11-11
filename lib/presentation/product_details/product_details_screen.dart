import 'package:flutter/material.dart';
import 'package:grocery_app/data/models/product_model.dart';
import 'package:grocery_app/presentation/components/check_connection.dart';
import 'package:grocery_app/presentation/components/custom_app_bar.dart';
import 'package:grocery_app/presentation/product_details/widgets/product_details_images.dart';
import 'package:grocery_app/presentation/product_details/widgets/product_details_sheet.dart';
import 'package:grocery_app/constants/style.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({
    super.key,
  });

  static const String id = "ProductDetailsScreen";
  @override
  Widget build(BuildContext context) {
    ProductModel product =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    return SafeArea(
      child: Scaffold(
          backgroundColor: MyColors.backgroundPrimary,
          extendBodyBehindAppBar: true,
          appBar: const CustomAppBar(
            title: "",
            color: Colors.transparent,
          ),
          body: CheckConnection(
            child: Column(
              children: [
                ProductDetailsImages(
                  images: product.images,
                ),
                ProductDetailsSheet(
                  product: product,
                )
              ],
            ),
          )),
    );
  }
}
