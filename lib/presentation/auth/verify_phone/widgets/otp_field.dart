import 'package:flutter/material.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:pinput/pinput.dart';

class OtpInput extends StatelessWidget {
  const OtpInput({super.key, this.onCompleted, this.controller});
  final void Function(String)? onCompleted;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Pinput(
          androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
          validator: (value) {
            return null;
          },
          onCompleted: onCompleted,
          controller: controller,
          length: 6,
          showCursor: false,
          defaultPinTheme: PinTheme(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: MyColors.backgroundPrimary),
              width: 56,
              height: 60,
              textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: MyFontWeights.medium,
                  color: MyColors.text)),
          focusedPinTheme: PinTheme(
              decoration: BoxDecoration(
                  border: Border.all(color: MyColors.primaryDark, width: 2),
                  borderRadius: BorderRadius.circular(6),
                  color: MyColors.backgroundPrimary),
              width: 60,
              height: 64,
              textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: MyFontWeights.medium,
                  color: MyColors.text))),
    );
  }
}
