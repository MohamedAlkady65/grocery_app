import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/logic/addresses_cubit/addresses_cubit.dart';
import 'package:grocery_app/presentation/add_address/widgets/add_adderss_body.dart';
import 'package:grocery_app/presentation/components/check_connection.dart';
import 'package:grocery_app/presentation/components/custom_app_bar.dart';
import 'package:grocery_app/constants/style.dart';

class AddAdderssScreen extends StatelessWidget {
  const AddAdderssScreen({super.key});

  static const String id = "AddAdderssScreen";

  @override
  Widget build(BuildContext context) {
    AddressesCubit addressesCubit =
        ModalRoute.of(context)!.settings.arguments as AddressesCubit;
    return Scaffold(
      backgroundColor: MyColors.backgroundSecondry,
      appBar:  CustomAppBar(
        title: S.of(context).addAddress,
      ),
      body: BlocProvider.value(
        value: addressesCubit,
        child: const CheckConnection(child: AddAddressBody()),
      ),
    );
  }
}
