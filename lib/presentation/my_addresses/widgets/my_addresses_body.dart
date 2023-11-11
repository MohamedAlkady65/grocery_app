import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/data/models/address_model.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:grocery_app/logic/addresses_cubit/addresses_cubit.dart';
import 'package:grocery_app/presentation/my_addresses/widgets/addresses_list.dart';
import 'package:grocery_app/presentation/my_addresses/widgets/empty_addresses_body.dart';
import 'package:grocery_app/presentation/my_addresses/widgets/my_addresses_loading.dart';

class MyAdderssesBody extends StatelessWidget {
  const MyAdderssesBody({super.key});
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AddressesCubit>(context).getAddresses();
    return BlocConsumer<AddressesCubit, AddressesState>(
      listener: (context, state) {
        if (state is RemoveAddresseLoading || state is EditAddresseLoading) {
          showLoadingDIalog(context);
        } else if (state is GetAddressesFailure) {
          showErrorSnackBar(context);
        } else if (state is RemoveAddresseSuccess ||
            state is EditAddresseSuccess) {
          Navigator.pop(context);
        } else if (state is RemoveAddresseFailure ||
            state is EditAddresseFailure) {
          showErrorSnackBar(context);
          Navigator.pop(context);
        }
      },
      buildWhen: (previous, current) => current is GetAddressesState,
      builder: (context, state) {
        if (state is GetAddressesSuccess) {
          List<AddressModel> addresses =
              BlocProvider.of<AddressesCubit>(context).addresses;
          if (addresses.isEmpty) {
            return const EmptyAddresses();
          } else {
            return SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: AddressesList(
                      addresses: addresses,
                    )));
          }
        } else if (state is GetAddressesLoading) {
          return const MyAddressesLoading();
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
