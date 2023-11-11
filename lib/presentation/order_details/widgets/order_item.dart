import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/data/models/order_item_model.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/presentation/product_details/product_details_screen.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({
    super.key,
    required this.orderItem,
  });

  final OrderItemModel orderItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        itemOnTap(context);
      },
      child: Container(
        color: MyColors.backgroundPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        height: 100,
        child: Row(
          children: [
            Container(
              width: 100,
              padding: const EdgeInsets.all(8),
              height: double.infinity,
              child: Center(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: getImage())),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    orderItem.title,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        color: MyColors.text,
                        fontWeight: MyFontWeights.semiBold,
                        fontSize: 18),
                  ),
                  Text(
                    orderItem.quantity,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        color: MyColors.textSecondry,
                        fontWeight: MyFontWeights.medium,
                        fontSize: 14),
                  ),
                  Text(
                    "${stringPrice(orderItem.price)} x ${orderItem.count}",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        color: MyColors.primary,
                        fontWeight: MyFontWeights.medium,
                        fontSize: 12),
                  ),
                  Text(
                    stringPrice(roundSafty(orderItem.price * orderItem.count)),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        color: MyColors.primaryDark,
                        fontWeight: MyFontWeights.medium,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void itemOnTap(BuildContext context) async {
    await Navigator.pushNamed(context, ProductDetailsScreen.id,
        arguments: orderItem.product);
  }

  Widget getImage() {
    return imageIsSvg(orderItem.imgUrl)
        ? SvgPicture.network(
            orderItem.imgUrl,
            height: double.infinity,
            fit: BoxFit.fitWidth,
          )
        : Image.network(
            orderItem.imgUrl,
            height: double.infinity,
            fit: BoxFit.fitWidth,
          );
  }
}
