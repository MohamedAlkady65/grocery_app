import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/constants/const.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/logic/addresses_cubit/addresses_cubit.dart';

class AddressTextField extends StatelessWidget {
  const AddressTextField(
      {super.key,
      this.onSaved,
      this.enabled,
      required this.hintText,
      required this.icon,
      this.onChanged,
      this.controller,
      this.validator});
  final void Function(String?)? onSaved;
  final bool? enabled;
  final String hintText;
  final IconData icon;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: kMaxLengthTextField,
      controller: controller,
      textInputAction: TextInputAction.done,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      onChanged: onChanged,
      validator: validator ??
          (value) {
            if (BlocProvider.of<AddressesCubit>(context).editAddressData.id ==
                null) {
              return null;
            }
            if (value != null && value.isEmpty) {
              return S.of(context).thisFieldIsRequired;
            }
            return null;
          },
      onSaved: onSaved,
      enabled: enabled,
      decoration: decoration(),
      style: TextStyle(
          color: MyColors.text, fontSize: 13, fontWeight: MyFontWeights.medium),
    );
  }

  InputDecoration decoration() {
    return InputDecoration(
        counterText: "",
        prefixIconColor: MaterialStateColor.resolveWith((states) =>
            states.contains(MaterialState.focused)
                ? MyColors.primaryDark
                : MyColors.textSecondry),
        contentPadding: EdgeInsets.zero,
        prefixIcon: Icon(icon),
        fillColor: MyColors.backgroundSecondry,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
            color: MyColors.textSecondry,
            fontSize: 13,
            fontWeight: MyFontWeights.medium),
        enabledBorder: border(MyColors.primary),
        focusedBorder: border(MyColors.primary),
        disabledBorder: border(MyColors.backgroundSecondry),
        errorBorder: border(MyColors.redDelete),
        focusedErrorBorder: border(MyColors.redDelete),
        border: border(MyColors.backgroundSecondry));
  }

  OutlineInputBorder border(Color color) {
    return OutlineInputBorder(
        borderSide: BorderSide(color: color),
        borderRadius: BorderRadius.circular(8));
  }
}
