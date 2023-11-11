import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/logic/addresses_cubit/addresses_cubit.dart';
import 'package:grocery_app/presentation/add_address/add_address_screen.dart';
import 'package:grocery_app/presentation/components/custom_text_button.dart';

class HeaderChooseAddress extends StatelessWidget {
  const HeaderChooseAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          S.of(context).deliveryAddress,
          style: TextStyle(
              fontSize: 20,
              color: MyColors.text,
              fontWeight: MyFontWeights.medium),
        ),
        CustomTextButton(
          color: MyColors.primaryDark,
          onPressed: () {
            Navigator.pushNamed(context, AddAdderssScreen.id,
                arguments: BlocProvider.of<AddressesCubit>(context));
          },
          child: Row(
            children: [
              const Icon(Icons.add),
              Text(
                S.of(context).addAddress,
                style:
                    TextStyle(fontWeight: MyFontWeights.medium, fontSize: 15),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
