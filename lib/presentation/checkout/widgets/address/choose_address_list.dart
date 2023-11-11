import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/data/models/address_model.dart';
import 'package:grocery_app/logic/addresses_cubit/addresses_cubit.dart';
import 'package:grocery_app/logic/checkout_cubit/checkout_cubit.dart';
import 'package:grocery_app/presentation/checkout/widgets/address/choose_address_empty_body.dart';
import 'package:grocery_app/presentation/checkout/widgets/address/choose_address_item.dart';

class ChooseAddressList extends StatelessWidget {
  const ChooseAddressList({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: BlocBuilder<AddressesCubit, AddressesState>(
          buildWhen: (previous, current) => current is GetAddressesState,
          builder: (context, state) {
            if (state is GetAddressesSuccess) {
              List<AddressModel> addresses = addressesList(context);

              BlocProvider.of<CheckoutCubit>(context).choosenAddress =
                  BlocProvider.of<AddressesCubit>(context).defaultAddressId;

              if (addresses.isEmpty) {
                return const ChooseAddressEmptyBody();
              } else {
                return StatefulBuilder(
                  builder: (context, setState) {
                    return ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => ChooseAddressItem(
                              groupValue:
                                  BlocProvider.of<CheckoutCubit>(context)
                                          .choosenAddress ??
                                      "",
                              onChanged: (value) {
                                setState(() {
                                  BlocProvider.of<CheckoutCubit>(context)
                                      .choosenAddress = value ?? "";
                                });
                              },
                              address: addresses[index],
                            ),
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 10,
                            ),
                        itemCount: addresses.length);
                  },
                );
              }
            } else if (state is GetAddressesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  List<AddressModel> addressesList(BuildContext context) {
    final List<AddressModel> list =
        BlocProvider.of<AddressesCubit>(context).addresses;

    final defInd = list.indexWhere((element) =>
        element.id ==
        BlocProvider.of<AddressesCubit>(context).defaultAddressId);

    if (defInd == -1) {
      return list;
    }

    final temp = list[defInd];
    list[defInd] = list[0];
    list[0] = temp;
    return list;
  }
}
