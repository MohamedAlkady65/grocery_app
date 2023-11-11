import 'package:flutter/material.dart';
import 'package:grocery_app/constants/style.dart';

enum StarType { empty, filled, half }

class Stars extends StatelessWidget {
  const Stars({super.key, required this.count});
  final double count;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$count",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14,
              fontWeight: MyFontWeights.medium,
              color: MyColors.text),
        ),
        const SizedBox(
          width: 5,
        ),
        ...fillStars()
      ],
    );
  }

  List<Icon> fillStars() {
    List<Icon> starsList = List.generate(5, (index) {
      if (index + 1 <= count) {
        return starIcon(StarType.filled);
      } else {
        return starIcon(StarType.empty);
      }
    });

    if (count > count.floor()) {
      starsList[count.floor()] = starIcon(StarType.half);
    }

    return starsList;
  }

  Icon starIcon(StarType type) {
    IconData icon;
    if (type == StarType.filled) {
      icon = Icons.star;
    } else if (type == StarType.empty) {
      icon = Icons.star_border;
    } else if (type == StarType.half) {
      icon = Icons.star_half;
    } else {
      throw Exception("Stars Exception Invalid Type");
    }

    return Icon(
      icon,
      color: const Color(0xffFFC107),
    );
  }
}
