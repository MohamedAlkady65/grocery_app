import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/data/models/address_model.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:grocery_app/logic/addresses_cubit/addresses_cubit.dart';
import 'package:grocery_app/logic/checkout_cubit/checkout_cubit.dart';
import 'package:grocery_app/presentation/add_address/add_address_screen.dart';
import 'package:grocery_app/presentation/checkout/widgets/address/choose_address_list.dart';
import 'package:grocery_app/presentation/checkout/widgets/address/header_choose_addres.dart';
import 'package:grocery_app/presentation/components/bright_button.dart';

class ChooseAddressBody extends StatelessWidget {
  const ChooseAddressBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        children: [
          const HeaderChooseAddress(),
          const ChooseAddressList(),
          BlocConsumer<AddressesCubit, AddressesState>(
            listener: (context, state) {
              if (state is GetAddressesFailure) {
                showErrorSnackBar(context);
              }
            },
            builder: (context, state) {
              if (!(state is GetAddressesSuccess ||
                  state is AddAddressSuccess)) {
                return const SizedBox();
              }

              List<AddressModel> address =
                  BlocProvider.of<AddressesCubit>(context).addresses;

              if (address.isEmpty) {
                return BrightButton(
                  text: S.of(context).addAddress,
                  onTap: () {
                    Navigator.pushNamed(context, AddAdderssScreen.id,
                        arguments: BlocProvider.of<AddressesCubit>(context));
                  },
                );
              } else {
                return BrightButton(
                  text: S.of(context).next,
                  onTap: () {
                    BlocProvider.of<CheckoutCubit>(context).nextStep();
                  },
                );
              }
            },
          )
        ],
      ),
    );
  }
}
