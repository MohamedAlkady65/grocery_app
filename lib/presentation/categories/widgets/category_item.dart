import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/data/models/category_model.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:grocery_app/presentation/products/products_category_screen.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.backgroundColor,
    required this.category,
  });

  final Color backgroundColor;
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ProductsCategoryScreen.id,
            arguments: category);
      },
      child: Container(
        color: backgroundColor,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(99999),
            child: getImage(),
          ),
          Text(
            category.title,
            style: TextStyle(
                fontWeight: MyFontWeights.medium,
                fontSize: 12,
                color: MyColors.textSecondry),
          )
        ]),
      ),
    );
  }

  Widget getImage() {
    return imageIsSvg(category.imgUrl)
        ? SvgPicture.network(
            category.imgUrl,
            width: 65,
            height: 65,
          )
        : Image.network(
            category.imgUrl,
            width: 65,
            height: 65,
          );
  }
}
