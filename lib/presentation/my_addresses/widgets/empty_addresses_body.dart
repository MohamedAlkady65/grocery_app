import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/logic/addresses_cubit/addresses_cubit.dart';
import 'package:grocery_app/presentation/add_address/add_address_screen.dart';
import 'package:grocery_app/presentation/components/bright_button.dart';
import 'package:grocery_app/constants/style.dart';

class EmptyAddresses extends StatelessWidget {
  const EmptyAddresses({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        children: [
          const Spacer(
            flex: 1,
          ),
          Center(
            child: Column(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 170,
                  color: MyColors.primaryDark,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  S.of(context).noAddressesYet,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: MyFontWeights.semiBold,
                      color: MyColors.text),
                )
              ],
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          BrightButton(
            text: S.of(context).addAddress,
            onTap: () {
              Navigator.pushNamed(context, AddAdderssScreen.id,
                  arguments: BlocProvider.of<AddressesCubit>(context));
            },
          )
        ],
      ),
    );
  }
}
