import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/logic/checkout_cubit/checkout_cubit.dart';
import 'package:grocery_app/presentation/components/bright_button.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/presentation/components/order_details_section.dart';

class OrderSuccessBody extends StatelessWidget {
  const OrderSuccessBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              Text(
                S.of(context).orderSuccesfull,
                textAlign: TextAlign.center,
                style: TextStyle(
                    height: 1.2,
                    fontSize: 28,
                    fontWeight: MyFontWeights.semiBold,
                    color: MyColors.text),
              ),
              const SizedBox(
                height: 24,
              ),
              OrderDetailsSection(
                  order: BlocProvider.of<CheckoutCubit>(context).successOrder),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: BrightButton(
            text: S.of(context).goShopping,
            onTap: () {
              BlocProvider.of<CheckoutCubit>(context).previousStep(context);
            },
          ),
        )
      ],
    );
  }
}
