import 'package:flutter/material.dart';

class MyColors {
  static late Color backgroundPrimary;
  static late Color backgroundSecondry;
  static late Color text;
  static late Color borderSecondry;
  static late Color backgroundThird;
  static late Color shimmerBaseColor;
  static late Color shimmerHighlightColor;

  static const Color primary = Color(0xffAEDC81);
  static const Color primaryDark = Color(0xff6CC51D);
  static const Color primaryLight = Color(0xffEBFFD7);
  static const Color grey = Color(0xffDCDCDC);
  static const Color greySecondry = Color(0xffE8E9E9);
  static const Color border = Color(0xffEBEBEB);
  static const Color textSecondry = Color(0xff868889);
  static const Color link = Color(0xff407EC7);
  static const Color red = Color(0xffFE585A);
  static const Color redDelete = Color(0xffEF574B);
  static const Color redWarning = Color(0xffD0342C);
  static const Color green = Color(0xff28B446);

  static void setLightTheme() {
    backgroundPrimary = const Color(0xffffffff);
    backgroundSecondry = const Color(0xfff4f5f9);
    text = const Color(0xff000000);
    borderSecondry = const Color(0xFFE7E7E7);
    backgroundThird = const Color(0xfff5f5f5);
    shimmerBaseColor = const Color(0xFFEBEBF4);
    shimmerHighlightColor = const Color(0xFFF4F4F4);
  }

  static void setDarkTheme() {
    backgroundPrimary = const Color(0xFF363636);
    backgroundSecondry = const Color(0xFF121212);
    text = const Color(0xFFFFFFFF);
    borderSecondry = const Color(0xFF575757);
    backgroundThird = const Color(0xff282828);
    shimmerBaseColor = const Color(0xFF3A3A3A);
    shimmerHighlightColor = const Color(0xFF3F3F3F);
  }
}

class MyFontWeights {
  static late FontWeight regular;
  static late FontWeight medium;
  static late FontWeight semiBold;
  static const FontWeight bold = FontWeight.bold;

  static void init(String? languageCode) {
    if (languageCode == "ar") {
      regular = FontWeight.w200;
      medium = FontWeight.w400;
      semiBold = FontWeight.w500;
    } else {
      regular = FontWeight.w300;
      medium = FontWeight.w500;
      semiBold = FontWeight.w600;
    }
  }
}

class MyFonts {
  static const String rubik = "Rubik";
  static const String poppins = "Poppins";
}

MaterialColor myPrimaryColor() {
  return MaterialColor(MyColors.primaryDark.value, <int, Color>{
    50: MyColors.primaryDark.withOpacity(0.1),
    100: MyColors.primaryDark.withOpacity(0.2),
    200: MyColors.primaryDark.withOpacity(0.3),
    300: MyColors.primaryDark.withOpacity(0.4),
    400: MyColors.primaryDark.withOpacity(0.5),
    500: MyColors.primaryDark.withOpacity(0.6),
    600: MyColors.primaryDark.withOpacity(0.7),
    700: MyColors.primaryDark.withOpacity(0.8),
    800: MyColors.primaryDark.withOpacity(0.9),
    900: MyColors.primaryDark.withOpacity(1.0),
  });
}
