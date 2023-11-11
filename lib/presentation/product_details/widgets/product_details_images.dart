import 'package:flutter/material.dart';
import 'package:grocery_app/data/models/product_model.dart';
import 'package:grocery_app/presentation/product_details/widgets/arrow_button.dart';
import 'package:grocery_app/presentation/product_details/widgets/images_indicator.dart';
import 'package:grocery_app/presentation/product_details/widgets/product_details_page_view.dart';

class ProductDetailsImages extends StatefulWidget {
  const ProductDetailsImages({super.key, required this.images});
  final List<ImageProduct> images;
  @override
  State<ProductDetailsImages> createState() => _ProductDetailsImagesState();
}

class _ProductDetailsImagesState extends State<ProductDetailsImages> {
  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          ProductDetailsPageView(
            controller: controller,
            images: widget.images,
          ),
          ArrowButton(
            iconData: Icons.arrow_back_ios,
            position: 0,
            onPressed: () {
              controller.previousPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.linear);
            },
          ),
          ArrowButton(
            iconData: Icons.arrow_forward_ios,
            position: 1,
            onPressed: () {
              controller.nextPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.linear);
            },
          ),
          ImagesIndicator(controller: controller, count: widget.images.length)
        ],
      ),
    );
  }
}
