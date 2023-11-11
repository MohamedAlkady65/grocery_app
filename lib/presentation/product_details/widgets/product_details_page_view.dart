import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/data/models/product_model.dart';
import 'package:grocery_app/helper/functions.dart';

class ProductDetailsPageView extends StatelessWidget {
  const ProductDetailsPageView({
    super.key,
    required this.controller,
    required this.images,
  });

  final PageController controller;
  final List<ImageProduct> images;

  @override
  Widget build(BuildContext context) {
    List<Widget> imagesWidget = [];

    for (int i = 0; i < images.length; i++) {
      if (images[i].isDefault) {
        imagesWidget.insert(
            0, Hero(tag: "heroTag", child: getImage(images[i])));
      } else {
        imagesWidget.add(getImage(images[i]));
      }
    }
    return PageView(
      controller: controller,
      children: imagesWidget,
    );
  }

  Widget getImage(ImageProduct img) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: imageIsSvg(img.imgUrl) 
          ? SvgPicture.network(
              img.imgUrl,
              fit: BoxFit.contain,
            )
          : Image.network(
              img.imgUrl,
              fit: BoxFit.contain,
            ),
    );
  }
}
