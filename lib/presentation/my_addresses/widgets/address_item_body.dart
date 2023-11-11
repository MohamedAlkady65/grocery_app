import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/data/models/address_model.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/logic/addresses_cubit/addresses_cubit.dart';
import 'package:grocery_app/presentation/components/custom_text_button.dart';
import 'package:grocery_app/presentation/components/switch_button.dart';
import 'package:grocery_app/presentation/my_addresses/widgets/address_text_field.dart';
import 'package:grocery_app/presentation/my_addresses/widgets/edit_country_drop_down.dart';

class AddressItemBody extends StatefulWidget {
  const AddressItemBody(
      {super.key,
      required this.address,
      required this.isDefault,
      required this.formKey});
  final AddressModel address;
  final bool isDefault;
  final GlobalKey<FormState> formKey;

  @override
  State<AddressItemBody> createState() => _AddressItemBodyState();
}

class _AddressItemBodyState extends State<AddressItemBody> {
  bool editing = false;

  @override
  Widget build(BuildContext context) {
    if (BlocProvider.of<AddressesCubit>(context).isThereEditing == false) {
      editing = false;
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            AddressTextField(
              controller: TextEditingController(text: widget.address.name),
              hintText: S.of(context).name,
              icon: Icons.account_circle_outlined,
              enabled: editing,
              onChanged: (value) {
                BlocProvider.of<AddressesCubit>(context)
                    .editAddressData
                    .editName(addressId: widget.address.id!, value: value);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            AddressTextField(
              controller: TextEditingController(text: widget.address.street),
              hintText: S.of(context).street,
              icon: Icons.location_on_outlined,
              enabled: editing,
              onChanged: (value) {
                BlocProvider.of<AddressesCubit>(context)
                    .editAddressData
                    .editStreet(addressId: widget.address.id!, value: value);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            EditCountryDropDown(
              address: widget.address,
              enabled: editing,
            ),
            const SizedBox(
              height: 10,
            ),
            AddressTextField(
              controller: TextEditingController(text: widget.address.city),
              hintText: S.of(context).city,
              icon: Icons.location_city_outlined,
              enabled: editing,
              onChanged: (value) {
                BlocProvider.of<AddressesCubit>(context)
                    .editAddressData
                    .editCity(addressId: widget.address.id!, value: value);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            AddressTextField(
              controller: TextEditingController(text: widget.address.zip),
              hintText: S.of(context).zipCode,
              icon: Icons.domain,
              enabled: editing,
              onChanged: (value) {
                BlocProvider.of<AddressesCubit>(context)
                    .editAddressData
                    .editZip(addressId: widget.address.id!, value: value);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            AddressTextField(
              controller: TextEditingController(
                  text: widget.address.phone.getPhoneText(context: context)),
              hintText: S.of(context).phone,
              icon: Icons.phone_outlined,
              enabled: editing,
              validator: (value) {
                return phoneValidator(context, value);
              },
              onChanged: (value) {
                BlocProvider.of<AddressesCubit>(context)
                    .editAddressData
                    .editPhone(addressId: widget.address.id!, value: value);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                if (editing &&
                    BlocProvider.of<AddressesCubit>(context).defaultAddressId !=
                        widget.address.id)
                  ...defaultButton(context),
                const Spacer(
                  flex: 1,
                ),
                CustomTextButton(
                  color: MyColors.primaryDark,
                  onPressed: () async {
                    if (editing == true) {
                      await BlocProvider.of<AddressesCubit>(context)
                          .editAddress(
                              context: context,
                              addressId: widget.address.id!,
                              formKey: widget.formKey,
                              setState: () {
                                setState(() {
                                  editing = false;
                                });
                              });
                    } else {
                      setState(() {
                        editing = true;
                      });
                      if (context.mounted) {
                        BlocProvider.of<AddressesCubit>(context)
                            .isThereEditing = true;
                      }
                    }
                  },
                  child: Text(
                    editing ? S.of(context).save : S.of(context).edit,
                    style: TextStyle(
                        color: MyColors.primaryDark,
                        fontWeight: MyFontWeights.medium,
                        fontSize: 16),
                  ),
                ),
                CustomTextButton(
                  color: MyColors.primaryDark,
                  onPressed: () {
                    if (editing == true) {
                      setState(() {
                        editing = false;
                        BlocProvider.of<AddressesCubit>(context)
                            .editAddressData
                            .clear();
                        widget.formKey.currentState!.validate();
                      });
                    } else {
                      BlocProvider.of<AddressesCubit>(context)
                          .removeAddress(addressId: widget.address.id!);
                    }
                  },
                  child: Text(
                    editing ? S.of(context).cancel : S.of(context).remove,
                    style: TextStyle(
                        color: MyColors.primaryDark,
                        fontWeight: MyFontWeights.medium,
                        fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String? phoneValidator(BuildContext context, String? value) {
    if (BlocProvider.of<AddressesCubit>(context).editAddressData.id == null) {
      return null;
    }
    if (value != null && value.isEmpty) {
      return S.of(context).thisFieldIsRequired;
    }
    return BlocProvider.of<AddressesCubit>(context)
        .editAddressData
        .phoneErrorMessage;
  }

  List<Widget> defaultButton(BuildContext context) {
    return [
      SwitchButton(
        scale: 0.7,
        onChanged: (value) {
          BlocProvider.of<AddressesCubit>(context)
              .editAddressData
              .editDefault(addressId: widget.address.id!, value: value);
        },
      ),
      Text(
        S.of(context).makeDefault,
        style: TextStyle(
            fontWeight: MyFontWeights.medium,
            fontSize: 12,
            color: MyColors.text),
      ),
    ];
  }
}
