
import 'package:flutter/material.dart';
import 'package:grocery_app/presentation/home/widgets/bottom_app_bar_item.dart';
import 'package:grocery_app/constants/style.dart';
class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({
    super.key,
    this.onTap,
    required this.currentIndex,
  });
  final void Function(int index)? onTap;
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: MyColors.backgroundThird,
      notchMargin: 5.0,
      elevation: 10,
      height: 60,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomAppBarItem(
            index: 0,
            iconData: Icons.home_outlined,
            onTap: onTap,
            color: currentIndex == 0 ? MyColors.text : MyColors.textSecondry,
          ),
          BottomAppBarItem(
            index: 1,
            iconData: Icons.account_circle_outlined,
            onTap: onTap,
            color: currentIndex == 1 ? MyColors.text : MyColors.textSecondry,
          ),
          BottomAppBarItem(
            index: 2,
            iconData: Icons.favorite_border,
            onTap: onTap,
            color: currentIndex == 2 ? MyColors.text : MyColors.textSecondry,
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
    );
  }
}