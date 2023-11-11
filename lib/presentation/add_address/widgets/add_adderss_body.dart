import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:grocery_app/logic/addresses_cubit/addresses_cubit.dart';
import 'package:grocery_app/presentation/add_address/widgets/country_drop_down.dart';
import 'package:grocery_app/presentation/components/bright_button.dart';
import 'package:grocery_app/presentation/components/custom_text_field.dart';
import 'package:grocery_app/presentation/components/switch_button.dart';
import 'package:grocery_app/constants/style.dart';

class AddAddressBody extends StatelessWidget {
  const AddAddressBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: BlocProvider.of<AddressesCubit>(context).formKey,
      child: BlocConsumer<AddressesCubit, AddressesState>(
        listener: (context, state) {
          if (state is AddAddressSuccess) {
            Navigator.pop(context);
          } else if (state is AddAddressFailure) {
            showErrorSnackBar(context);
          }
        },
        builder: (context, state) {
          return AbsorbPointer(
            absorbing: state is AddAddressLoading,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                CustomTextField(
                  hintText: S.of(context).name,
                  icon: const Icon(Icons.account_circle_outlined),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).pleaseEnterYourName;
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    BlocProvider.of<AddressesCubit>(context).addressData.name =
                        value ?? "";
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const CountryDropDown(),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: S.of(context).street,
                  icon: const Icon(Icons.location_on_outlined),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).pleaseEnterYourStreet;
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    BlocProvider.of<AddressesCubit>(context)
                        .addressData
                        .street = value ?? "";
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: S.of(context).city,
                  icon: const Icon(Icons.location_city_outlined),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).pleaseEnterYourCity;
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    BlocProvider.of<AddressesCubit>(context).addressData.city =
                        value ?? "";
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  keyboardType: TextInputType.number,
                  hintText: S.of(context).zipCode,
                  icon: const Icon(Icons.domain),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).pleaseEnterYourZipCode;
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    BlocProvider.of<AddressesCubit>(context).addressData.zip =
                        value ?? "";
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  inputAction: TextInputAction.done,
                  keyboardType: TextInputType.phone,
                  hintText: S.of(context).phone,
                  icon: const Icon(Icons.phone_outlined),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).pleaseEnterPhoneNumber;
                    } else {
                      return BlocProvider.of<AddressesCubit>(context)
                          .phoneFieldErrorMessage;
                    }
                  },
                  onSaved: (value) {
                    BlocProvider.of<AddressesCubit>(context)
                        .addressData
                        .phoneText = value ?? "";
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SwitchButton(
                      scale: 0.7,
                      onChanged: (value) {
                        BlocProvider.of<AddressesCubit>(context)
                            .addressData
                            .isDefault = value;
                      },
                    ),
                    Text(
                      S.of(context).makeDefault,
                      style: TextStyle(
                          fontWeight: MyFontWeights.medium,
                          fontSize: 12,
                          color: MyColors.text),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                BrightButton(
                  isLoading: state is AddAddressLoading,
                  text: S.of(context).addAddress,
                  onTap: () {
                    BlocProvider.of<AddressesCubit>(context).add(context);
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
