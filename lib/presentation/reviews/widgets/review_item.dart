import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/data/models/review_model.dart';
import 'package:grocery_app/helper/date_helper.dart';
import 'package:grocery_app/presentation/components/stars.dart';
import 'package:grocery_app/constants/style.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({super.key, required this.review});
  final ReviewModel review;
  @override
  Widget build(BuildContext context) {
    final date = DateHelper.getFromDate(context: context, date: review.date);
    return Container(
      color: MyColors.backgroundPrimary,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              getUserImage(),
              const SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.username ?? "",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: MyFontWeights.semiBold,
                        color: MyColors.text),
                  ),
                  Text(
                    date.toString(),
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: MyFontWeights.medium,
                        color: MyColors.textSecondry),
                  ),
                ],
              )
            ],
          ),
          const Divider(
            color: MyColors.border,
            thickness: 1,
            height: 30,
          ),
          Stars(
            count: review.rate,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            review.comment,
            style: TextStyle(
                fontSize: 14,
                fontWeight: MyFontWeights.regular,
                color: MyColors.textSecondry),
          ),
        ],
      ),
    );
  }

  Widget getUserImage() {
    if (review.userImgUrl == null || review.userImgUrl == "") {
      return ClipRRect(
        borderRadius: BorderRadius.circular(999999),
        child: ColoredBox(
            color: Colors.white,
            child: SvgPicture.asset(
              "assets/images/default_user_image.svg",
              width: 50,
              height: 50,
            )),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(99999),
        child: Image.network(
          review.userImgUrl!,
          width: 50,
          height: 50,
          fit: BoxFit.fill,
        ),
      );
    }
  }
}
