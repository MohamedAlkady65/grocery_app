import 'package:flutter/material.dart';
import 'package:grocery_app/data/models/product_model.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:grocery_app/presentation/product_details/widgets/rating_info.dart';
import 'package:grocery_app/presentation/product_details/widgets/cart_button_product_details.dart';
import 'package:grocery_app/presentation/product_details/widgets/expand_text_product_desc.dart';
import 'package:grocery_app/presentation/product_details/widgets/favorite_icon_button_product_details.dart';
import 'package:grocery_app/constants/style.dart';

class ProductDetailsSheet extends StatelessWidget {
  const ProductDetailsSheet({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height / 2,
      color: MyColors.backgroundSecondry,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                stringPrice(product.price),
                style: TextStyle(
                    color: MyColors.green,
                    fontWeight: MyFontWeights.semiBold,
                    fontSize: 18),
              ),
              FavoriteIconButtonProductDetails(product: product)
            ],
          ),
          Text(
            product.title,
            style: TextStyle(
                color: MyColors.text,
                fontWeight: MyFontWeights.semiBold,
                fontSize: 20),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            product.quantity,
            style: TextStyle(
                color: MyColors.textSecondry,
                fontWeight: MyFontWeights.medium,
                fontSize: 14),
          ),
          RatingInfo(product: product),
          ExpandTextProductDesc(
            text: product.description,
          ),
          const SizedBox(
            height: 20,
          ),
          CartButtonProductDetails(product: product),
        ],
      ),
    );
  }
}
