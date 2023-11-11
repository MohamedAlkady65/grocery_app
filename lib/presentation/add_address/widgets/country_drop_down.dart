import 'package:collection/collection.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/helper/countries.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:grocery_app/logic/addresses_cubit/addresses_cubit.dart';
import 'package:grocery_app/logic/info_cubit/info_cubit.dart';
import 'package:intl/intl.dart';

class CountryDropDown extends StatefulWidget {
  const CountryDropDown({super.key});

  @override
  State<CountryDropDown> createState() => _CountryDropDownState();
}

class _CountryDropDownState extends State<CountryDropDown> {
  late AddressesCubit addressesCubit;
  late List<Map<String, String>> countiresList;
  @override
  void initState() {
    addressesCubit = BlocProvider.of<AddressesCubit>(context);
    addressesCubit.addressData.countryCode =
        BlocProvider.of<InfoCubit>(context).ipInfo?.countryCode2 ?? "";
    countiresList =
        Intl.getCurrentLocale() == 'ar' ? Counrties.arabic : Counrties.english;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Map<String, String>>(
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: decoration(),
        baseStyle: TextStyle(
            fontSize: 16,
            fontWeight: MyFontWeights.medium,
            color: MyColors.text),
      ),
      popupProps: popupProps(),
      validator: (value) {
        if (addressesCubit.addressData.countryCode == "") {
          return S.of(context).pleaseChooseYourCountry;
        } else {
          return null;
        }
      },
      selectedItem: countiresList.firstWhereOrNull((element) =>
          element['code'] == addressesCubit.addressData.countryCode),
      items: countiresList,
      itemAsString: (item) => item['name']!,
      onChanged: (value) {
        print(123);
        addressesCubit.addressData.countryCode = value!['code'] ?? "";
      },
    );
  }

  PopupProps<Map<String, String>> popupProps() {
    return PopupProps.menu(
      fit: FlexFit.loose,
      menuProps: MenuProps(
        backgroundColor: MyColors.backgroundPrimary,
        elevation: 3,
      ),
      itemBuilder: (context, item, isSelected) => ListTile(
        minLeadingWidth: 10,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(getFlagFromCountryCode(item['code']!)),
          ],
        ),
        title: Text(
          item['name']!,
          style: TextStyle(
              fontSize: 16,
              fontWeight: MyFontWeights.medium,
              color: MyColors.text),
        ),
      ),
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
        prefixIcon: const Icon(Icons.language),
        hintText: S.of(context).country,
        hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: MyFontWeights.medium,
            color: MyColors.textSecondry),
        filled: true,
        fillColor: MyColors.backgroundPrimary);
  }

  OutlineInputBorder buildBorder({required Color color}) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: color, width: 1));
  }
}
