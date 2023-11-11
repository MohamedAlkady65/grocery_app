import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocery_app/constants/enums.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/logic/checkout_cubit/checkout_cubit.dart';
import 'package:grocery_app/presentation/checkout/widgets/payment/choose_payment_item.dart';

class ChoosePaymentMethod extends StatefulWidget {
  const ChoosePaymentMethod({super.key});

  @override
  State<ChoosePaymentMethod> createState() => _ChoosePaymentMethodState();
}

class _ChoosePaymentMethodState extends State<ChoosePaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PaymentMethodItem(
          icon: FontAwesomeIcons.handHoldingDollar,
          groupValue: BlocProvider.of<CheckoutCubit>(context).choosenMethod,
          text: S.of(context).cashOnDelivery,
          value: PaymentMethod.cash,
          onChanged: (value) {
            setState(() {
              BlocProvider.of<CheckoutCubit>(context).choosenMethod = value;
            });
          },
        ),
        PaymentMethodItem(
          icon: FontAwesomeIcons.creditCard,
          groupValue: BlocProvider.of<CheckoutCubit>(context).choosenMethod,
          text: S.of(context).creditCard,
          value: PaymentMethod.creditCard,
          onChanged: (value) {
            setState(() {
              BlocProvider.of<CheckoutCubit>(context).choosenMethod = value;
            });
          },
        ),
      ],
    );
  }
}
