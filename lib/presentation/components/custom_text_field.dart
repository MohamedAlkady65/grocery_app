import 'package:flutter/material.dart';
import 'package:grocery_app/constants/const.dart';
import 'package:grocery_app/constants/style.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      this.password = false,
      required this.hintText,
      required this.icon,
      this.maxLines = 1,
      this.inputAction = TextInputAction.next,
      this.validator,
      this.onSaved,
      this.initialValue,
      this.enabled = true,
      this.suffixIcon,
      this.keyboardType,
      this.onChanged,
      this.maxLength = kMaxLengthTextField});
  final bool password;
  final String hintText;
  final String? initialValue;
  final Icon icon;
  final int maxLines;
  final TextInputAction inputAction;
  final bool enabled;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final int maxLength;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool hidden = true;
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: widget.maxLength,
      focusNode: focusNode,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      enabled: widget.enabled,
      initialValue: widget.initialValue,
      validator: widget.validator,
      onSaved: widget.onSaved,
      textInputAction:
          widget.maxLines == 1 ? widget.inputAction : TextInputAction.newline,
      decoration: decoration(),
      style: TextStyle(
          fontSize: 16, fontWeight: MyFontWeights.medium, color: MyColors.text),
      obscureText: widget.password && hidden,
      maxLines: widget.maxLines,
    );
  }

  InputDecoration decoration() {
    return InputDecoration(
        counterText: "",
        prefixIconColor: MaterialStateColor.resolveWith((states) =>
            states.contains(MaterialState.focused)
                ? MyColors.primaryDark
                : MyColors.textSecondry),
        suffixIconColor: MaterialStateColor.resolveWith((states) =>
            states.contains(MaterialState.focused)
                ? MyColors.primaryDark
                : MyColors.textSecondry),
        enabledBorder: buildBorder(color: MyColors.backgroundPrimary),
        disabledBorder: buildBorder(color: MyColors.backgroundPrimary),
        focusedBorder: buildBorder(color: MyColors.primaryDark),
        errorBorder: buildBorder(color: MyColors.redDelete),
        focusedErrorBorder: buildBorder(color: MyColors.redDelete),
        errorStyle: TextStyle(color: MyColors.redDelete),
        prefixIcon: widget.icon,
        suffixIcon: widget.suffixIcon ?? visibilityIcon(),
        hintText: widget.hintText,
        hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: MyFontWeights.medium,
            color: MyColors.textSecondry),
        filled: true,
        fillColor: MyColors.backgroundPrimary);
  }

  IconButton? visibilityIcon() {
    return widget.password
        ? IconButton(
            splashRadius: 1,
            onPressed: () {
              setState(() {
                hidden = hidden ? false : true;
              });
            },
            icon: Icon(
              hidden
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              size: 28,
            ))
        : null;
  }

  OutlineInputBorder buildBorder({required Color color}) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: color, width: 1));
  }
}
