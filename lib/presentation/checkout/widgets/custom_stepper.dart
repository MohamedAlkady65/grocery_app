import 'package:flutter/material.dart';
import 'package:grocery_app/constants/style.dart';

class CustomStepper extends StatelessWidget {
  const CustomStepper(
      {super.key, required this.currentStep, required this.titles});
  final int currentStep;
  final List<String> titles;
  @override
  Widget build(BuildContext context) {
    stepsListBuilder();

    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 32, right: 32),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: stepsListBuilder()),
    );
  }

  List<Widget> stepsListBuilder() {
    return titles.isEmpty
        ? []
        : List<Widget>.generate(titles.length * 2 - 1, (index) {
            if (index % 2 == 0) {
              return circle(
                  state: currentStep * 2 == index
                      ? 1
                      : currentStep * 2 > index
                          ? 2
                          : 0,
                  number: (index ~/ 2) + 1,
                  title: titles[index ~/ 2]);
            } else {
              return line(index < currentStep * 2 ? 1 : 0);
            }
          });
  }

  Widget line(int state) {
    return Expanded(
        child: Container(
      color: state == 1 ? MyColors.primaryDark : MyColors.borderSecondry,
      height: 1,
    ));
  }

  Widget circle(
      {required int state, required int number, required String title}) {
    return Column(
      children: [
        const SizedBox(
          height: 25,
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              border: Border.all(
                  color: state == 0
                      ? MyColors.borderSecondry
                      : MyColors.primaryDark,
                  width: 1),
              color: state != 0
                  ? MyColors.primaryDark
                  : MyColors.backgroundPrimary,
              borderRadius: BorderRadius.circular(9999999)),
          child: Center(
            child: state == 2
                ? Icon(
                    Icons.check,
                    color: MyColors.backgroundPrimary,
                  )
                : Text(
                    "$number",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: MyFontWeights.medium,
                        color: state == 1
                            ? MyColors.backgroundPrimary
                            : MyColors.textSecondry),
                  ),
          ),
        ),
        SizedBox(
          height: 25,
          child: Center(
            child: Text(title,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: MyFontWeights.medium,
                    color: MyColors.textSecondry)),
          ),
        )
      ],
    );
  }
}
