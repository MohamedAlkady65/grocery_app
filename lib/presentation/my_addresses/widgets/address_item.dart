import 'package:flutter/material.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/data/models/address_model.dart';
import 'package:grocery_app/presentation/my_addresses/widgets/address_item_body.dart';
import 'package:grocery_app/presentation/my_addresses/widgets/address_item_header.dart';

class AddressItem {
  final AddressModel address;
  final bool isDefault;
  AddressItem({required this.address, required this.isDefault});
  ExpansionPanel call() {
    return ExpansionPanel(
        backgroundColor: MyColors.backgroundPrimary,
        isExpanded: address.isExpanded,
        headerBuilder: (context, isExpanded) => AddressItemHeader(
              address: address,
              isDefault: isDefault,
            ),
        body: AddressItemBody(
          address: address,
          isDefault: isDefault,
          formKey: GlobalKey(),
        ));
  }
}
