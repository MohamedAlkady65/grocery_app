import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/data/models/landing_item_model.dart';
import 'package:grocery_app/helper/functions.dart';

class Landingitem extends StatelessWidget {
  const Landingitem({
    super.key,
    required this.landingItem,
  });
  final LandingItemModel landingItem;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        getImage(),
        Positioned(
            left: isArabic() ? null : 50,
            right: isArabic() ? 50 : null,
            bottom: 80,
            child: SizedBox(
              width: 160,
              child: Text(
                landingItem.text,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: MyFontWeights.semiBold,
                    color: Colors.black),
              ),
            )),
      ],
    );
  }

  Widget getImage() {
    return Transform.flip(
      flipX: isArabic() ? true : false,
      child: imageIsSvg(landingItem.imgUrl)
          ? SvgPicture.network(
              landingItem.imgUrl,
              fit: BoxFit.cover,
            )
          : Image.network(
              landingItem.imgUrl,
              fit: BoxFit.cover,
            ),
    );
  }
}
