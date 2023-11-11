import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/logic/addresses_cubit/addresses_cubit.dart';
import 'package:grocery_app/presentation/add_address/add_address_screen.dart';
import 'package:grocery_app/presentation/components/check_connection.dart';
import 'package:grocery_app/presentation/components/custom_app_bar.dart';
import 'package:grocery_app/presentation/components/icon_button_app_bar_action.dart';
import 'package:grocery_app/presentation/my_addresses/widgets/my_addresses_body.dart';
import 'package:grocery_app/constants/style.dart';

class MyAddressesScreen extends StatelessWidget {
  const MyAddressesScreen({super.key});
  static const String id = "MyAddressesScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundSecondry,
      appBar: CustomAppBar(
          title: S.of(context).myAddresses, actions: addAddressButton(context)),
      body: const CheckConnection(child: MyAdderssesBody()),
    );
  }

  List<IconButtonAppBarAction> addAddressButton(BuildContext context) => [
        IconButtonAppBarAction(
          icon: Icon(
            Icons.add_circle_outline,
            color: MyColors.text,
          ),
          onPressed: () {
            Navigator.pushNamed(context, AddAdderssScreen.id,
                arguments: BlocProvider.of<AddressesCubit>(context));
          },
        )
      ];
}
