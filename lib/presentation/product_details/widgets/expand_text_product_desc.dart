import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/generated/l10n.dart';

class ExpandTextProductDesc extends StatelessWidget {
  const ExpandTextProductDesc({super.key, required this.text});
  final String text;
  final double fontSize = 14;
  final double fontHeight = 1.2;
  @override
  Widget build(BuildContext context) {
    return Expanded(child: LayoutBuilder(
      builder: (context, constraints) {
        int maxLines =
            (constraints.maxHeight / (fontHeight * fontSize)).floor();
        maxLines = maxLines >= 2 ? maxLines - 1 : 1;
        return SingleChildScrollView(
            child: ExpandableText(
          text,
          expandText:  S.of(context).showMore,
          collapseText:  S.of(context).showLess,
          collapseOnTextTap: true,
          expandOnTextTap: true,
          maxLines: maxLines,
          linkStyle: TextStyle(
              color: MyColors.text,
              fontWeight: MyFontWeights.medium,
              fontSize: fontSize,
              height: fontHeight),
          style: TextStyle(
              color: MyColors.textSecondry,
              fontWeight: MyFontWeights.regular,
              fontSize: fontSize,
              height: fontHeight),
        ));
      },
    ));
  }
}
