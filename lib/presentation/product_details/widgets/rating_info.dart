import 'package:flutter/material.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/data/models/product_model.dart';
import 'package:grocery_app/presentation/components/custom_text_button.dart';
import 'package:grocery_app/presentation/components/stars.dart';
import 'package:grocery_app/presentation/reviews/reviews_screen.dart';

class RatingInfo extends StatefulWidget {
  const RatingInfo({super.key, required this.product});
  final ProductModel product;

  @override
  State<RatingInfo> createState() => _RatingInfoState();
}

class _RatingInfoState extends State<RatingInfo> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stars(count: widget.product.rate),
        CustomTextButton(
            color: MyColors.link,
            onPressed: () async {
              await Navigator.pushNamed(context, ReviewsScreen.id,
                  arguments: widget.product.id);

              setState(() {});
            },
            child: Text(
              "${widget.product.reviewsCount} review${widget.product.reviewsCount == 1 ? "" : "s"}",
              style: TextStyle(
                  color: MyColors.link,
                  fontWeight: MyFontWeights.medium,
                  fontSize: 14),
            ))
      ],
    );
  }
}
