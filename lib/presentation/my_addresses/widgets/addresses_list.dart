import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/data/models/address_model.dart';
import 'package:grocery_app/logic/addresses_cubit/addresses_cubit.dart';
import 'package:grocery_app/presentation/my_addresses/widgets/address_item.dart';

class AddressesList extends StatefulWidget {
  const AddressesList({
    super.key,
    required this.addresses,
  });
  final List<AddressModel> addresses;
  @override
  State<AddressesList> createState() => _AddressesListState();
}

class _AddressesListState extends State<AddressesList> {
  List<ExpansionPanel> addressesBuilder = [];

  @override
  Widget build(BuildContext context) {
    addressesBuilder.clear();
    int? defaultIndex;
    for (int i = 0; i < widget.addresses.length; i++) {
      addressesBuilder.add(AddressItem(
          address: widget.addresses[i],
          isDefault:
              BlocProvider.of<AddressesCubit>(context).defaultAddressId ==
                  widget.addresses[i].id)());

      if (BlocProvider.of<AddressesCubit>(context).defaultAddressId ==
          widget.addresses[i].id) {
        defaultIndex = i;
        ExpansionPanel temp = addressesBuilder[0];
        addressesBuilder[0] = addressesBuilder[i];
        addressesBuilder[i] = temp;
      }
    }
    return ExpansionPanelList(
      elevation: 0,
      expansionCallback: (panelIndex, isExpanded) {
        setState(() {
          if (panelIndex == 0) {
            panelIndex = defaultIndex ?? 0;
          } else if (panelIndex == defaultIndex) {
            panelIndex = 0;
          }

          BlocProvider.of<AddressesCubit>(context).isThereEditing = false;
          BlocProvider.of<AddressesCubit>(context).editAddressData.clear();

          widget.addresses
              .firstWhereOrNull((element) => element.isExpanded)
              ?.isExpanded = false;

          widget.addresses[panelIndex].isExpanded = isExpanded;
        });
      },
      animationDuration: const Duration(milliseconds: 400),
      expandedHeaderPadding: EdgeInsets.zero,
      expandIconColor: MyColors.textSecondry,
      children: addressesBuilder,
    );
  }
}
