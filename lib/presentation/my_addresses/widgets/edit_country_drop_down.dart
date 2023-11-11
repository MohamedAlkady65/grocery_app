import 'package:collection/collection.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/data/models/address_model.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/helper/countries.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:grocery_app/logic/addresses_cubit/addresses_cubit.dart';
import 'package:intl/intl.dart';

class EditCountryDropDown extends StatelessWidget {
  const EditCountryDropDown(
      {super.key, required this.address, required this.enabled});
  final AddressModel address;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> countiresList =
        Intl.getCurrentLocale() == 'ar' ? Counrties.arabic : Counrties.english;
    return DropdownSearch<Map<String, String>>(
      key: UniqueKey(),
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: decoration(context),
        baseStyle: TextStyle(
            color: MyColors.text,
            fontSize: 13,
            fontWeight: MyFontWeights.medium),
      ),
      popupProps: popupProps(),
      enabled: enabled,
      selectedItem: countiresList.firstWhereOrNull(
          (element) => element['code'] == address.countryCode),
      items: countiresList,
      itemAsString: (item) => item['name']!,
      onChanged: (value) {
        BlocProvider.of<AddressesCubit>(context)
            .editAddressData
            .editCountry(addressId: address.id!, value: value!['code']!);
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
              color: MyColors.text,
              fontSize: 13,
              fontWeight: MyFontWeights.medium),
        ),
      ),
    );
  }

  InputDecoration decoration(BuildContext context) {
    return InputDecoration(
        counterText: "",
        prefixIconColor: MaterialStateColor.resolveWith((states) =>
            states.contains(MaterialState.focused)
                ? MyColors.primaryDark
                : MyColors.textSecondry),
        contentPadding: EdgeInsets.zero,
        prefixIcon: const Icon(Icons.language),
        fillColor: MyColors.backgroundSecondry,
        filled: true,
        hintText: S.of(context).country,
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
