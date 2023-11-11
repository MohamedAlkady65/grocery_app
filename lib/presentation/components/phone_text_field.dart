import 'package:flutter/material.dart';
import 'package:grocery_app/constants/const.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneTextField extends StatelessWidget {
  const PhoneTextField(
      {super.key,
      this.initialValue,
      this.onInputChanged,
      required this.phoneTextFieldKey,
      this.validator});
  final PhoneNumber? initialValue;
  final void Function(PhoneNumber)? onInputChanged;
  final GlobalKey<FormFieldState> phoneTextFieldKey;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      keyboardAction: TextInputAction.done,
      maxLength: kMaxLengthTextField,
      validator: validator,
      fieldKey: phoneTextFieldKey,
      initialValue: initialValue,
      autoFocusSearch: true,
      selectorConfig: const SelectorConfig(
          selectorType: PhoneInputSelectorType.DIALOG, trailingSpace: false),
      inputDecoration: inputDecoration(context),
      onInputChanged: onInputChanged,
      textStyle: TextStyle(
          fontSize: 16, fontWeight: MyFontWeights.medium, color: MyColors.text),
    );
  }

  InputDecoration inputDecoration(BuildContext context) => InputDecoration(
      counterText: "",
      enabledBorder: border(MyColors.backgroundPrimary),
      focusedBorder: border(MyColors.primaryDark),
      errorBorder: border(MyColors.redDelete),
      focusedErrorBorder: border(MyColors.redDelete),
      hintText: S.of(context).phone,
      hintStyle: TextStyle(
          fontSize: 16,
          fontWeight: MyFontWeights.medium,
          color: MyColors.textSecondry),
      filled: true,
      fillColor: MyColors.backgroundPrimary);

  OutlineInputBorder border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(color: color, width: 1),
    );
  }
}
