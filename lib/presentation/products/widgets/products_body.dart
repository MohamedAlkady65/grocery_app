import 'package:flutter/material.dart';
import 'package:grocery_app/data/models/product_model.dart';
import 'package:grocery_app/presentation/products/widgets/product_item.dart';

class ProductsBody extends StatelessWidget {
  const ProductsBody(
      {super.key,
      this.shrinkWrap = false,
      this.padding,
      this.products = const [],
      this.itemsLength});
  final bool shrinkWrap;
  final EdgeInsets? padding;
  final List<ProductModel> products;
  final int? itemsLength;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap
          ? const NeverScrollableScrollPhysics()
          : const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 180,
          childAspectRatio: 0.77,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15),
      itemCount: itemsLength == null
          ? products.length
          : itemsLength! > products.length
              ? products.length
              : itemsLength,
      itemBuilder: (context, index) => ProductItem(
        product: products[index],
      ),
    );
  }

}
