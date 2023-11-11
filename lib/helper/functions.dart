import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/logic/info_cubit/info_cubit.dart';
import 'package:grocery_app/presentation/components/custom_text_button.dart';
import 'package:intl/intl.dart';

String stringPrice(double price) => "\$${price.toStringAsFixed(2)}";

//Solve Rounding Errors
double roundSafty(double value, {double precision = 100000}) =>
    (value * precision).round() / precision;
//Example 65.3*6 = 391.79999999999995

String randNumFixedDigits(int length) {
  String num = "";
  final rand = Random();
  num += (1 + rand.nextInt(9)).toString();
  for (int i = 0; i < length - 1; i++) {
    num += rand.nextInt(10).toString();
  }

  return num;
}

void showToastWarning(
    {required BuildContext context,
    required String message,
    bool top = false}) {
  FToast()
    ..init(context)
    ..showToast(
      fadeDuration: const Duration(milliseconds: 80),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: MyColors.redWarning,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.info,
              color: MyColors.backgroundPrimary,
            ),
            const SizedBox(
              width: 12.0,
            ),
            Text(
              message,
              style: TextStyle(color: MyColors.backgroundPrimary),
            ),
          ],
        ),
      ),
      positionedToastBuilder: (context, child) => top
          ? Positioned(left: 0, right: 0, top: 40, child: child)
          : Positioned(left: 0, right: 0, bottom: 90, child: child),
    );
}

void showDefaultToast(BuildContext context, String message) {
  FToast()
    ..init(context)
    ..showToast(
      fadeDuration: const Duration(milliseconds: 150),
      toastDuration: const Duration(milliseconds: 1500),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: const Color(0xFF666666),
        ),
        child: Text(
          message,
          style: TextStyle(color: MyColors.backgroundPrimary),
        ),
      ),
      positionedToastBuilder: (context, child) =>
          Positioned(left: 0, right: 0, bottom: 70, child: child),
    );
}

void showErrorSnackBar(BuildContext context, {String? message}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: AwesomeSnackbarContent(
          title: S.of(context).error,
          message: message ?? S.of(context).somethingWentWrong,
          contentType: ContentType.failure)));
}

void showFailedAwesomeDialog(
    {required String title,
    required String desc,
    required BuildContext context}) {
  AwesomeDialog(
          dialogBackgroundColor: MyColors.backgroundPrimary,
          context: context,
          dialogType: DialogType.error,
          title: title,
          titleTextStyle: TextStyle(
              color: MyColors.text,
              fontWeight: MyFontWeights.semiBold,
              fontSize: 20),
          descTextStyle: TextStyle(color: MyColors.text),
          desc: desc,
          headerAnimationLoop: false)
      .show();
}

void showSuccessSnackBar(BuildContext context,
    {String? message, String? title}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: AwesomeSnackbarContent(
          title: title ?? S.of(context).successS,
          message: message ?? S.of(context).successfully,
          contentType: ContentType.success)));
}

void showLoadingDIalog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => WillPopScope(
      onWillPop: () => Future.value(false),
      child: AlertDialog(
        backgroundColor: MyColors.backgroundPrimary,
        content: Container(
          color: MyColors.backgroundPrimary,
          width: 100,
          height: 100,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    ),
  );
}

void showSuringDIalog({
  required BuildContext context,
  required String title,
  required String content,
  void Function()? okCallBack,
  void Function()? cancelCallback,
  String? okText,
  String? cancelText,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: MyColors.backgroundPrimary,
      actions: [
        dialogButton(text: okText ?? S.of(context).Ok, onPressed: okCallBack),
        dialogButton(
            text: cancelText ?? S.of(context).cancel,
            onPressed: cancelCallback ??
                () {
                  Navigator.pop(context);
                }),
      ],
      contentPadding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      title: Text(
        title,
        style: TextStyle(
            color: MyColors.text,
            fontWeight: MyFontWeights.medium,
            fontSize: 22),
      ),
      content: Text(content,
          style: TextStyle(
              color: MyColors.text,
              fontWeight: MyFontWeights.regular,
              fontSize: 16)),
    ),
  );
}

CustomTextButton dialogButton(
    {required String text, required void Function()? onPressed}) {
  return CustomTextButton(
    onPressed: onPressed,
    color: MyColors.primaryDark,
    child: Text(
      text,
      style:  TextStyle(
          color: MyColors.primaryDark,
          fontWeight: MyFontWeights.medium,
          fontSize: 16),
    ),
  );
}

bool imageIsSvg(String imgUrl) {
  List<String> path = Uri.parse(imgUrl).pathSegments;
  if (path.isEmpty) return false;
  return path.last.split('.').last == "svg";
}

String getFlagFromCountryCode(String code) {
  return code.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
      (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
}

DateTime setNowDate(BuildContext context) {
  return DateTime.now().subtract(
      BlocProvider.of<InfoCubit>(context).ipInfo?.offset ?? Duration.zero);
}

bool isArabic() => Intl.getCurrentLocale() == "ar";
