import 'package:flutter/material.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/data/models/address_model.dart';

class ChooseAddressItem extends StatelessWidget {
  const ChooseAddressItem({
    super.key,
    required this.address,
    required this.groupValue,
    this.onChanged,
  });

  final AddressModel address;
  final String groupValue;
  final void Function(String?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: MyColors.backgroundPrimary,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: RadioListTile<String>(
        groupValue: groupValue,
        value: address.id!,
        onChanged: onChanged,
        secondary: const Icon(
          Icons.location_on,
          color: MyColors.primaryDark,
          size: 34,
        ),
        tileColor: MyColors.backgroundPrimary,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        activeColor: MyColors.primaryDark,
        selected: groupValue == address.id,
        selectedTileColor: MyColors.borderSecondry,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        // toggleable: true,//for cancle choice by click more time
        isThreeLine: true,
        title: Text(
          address.name,
          style: TextStyle(
              fontWeight: MyFontWeights.semiBold,
              fontSize: 15,
              color: MyColors.text),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${address.street}, ${address.city}, ${address.country(context)}",
              style: TextStyle(
                  fontWeight: MyFontWeights.medium,
                  fontSize: 12,
                  color: MyColors.textSecondry),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              address.phone.getPhoneText(context: context),
              style: TextStyle(
                  fontSize: 10,
                  color: MyColors.text,
                  fontWeight: MyFontWeights.semiBold),
            )
          ],
        ),
      ),
    );
  }
}
