import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/logic/addresses_cubit/addresses_cubit.dart';
import 'package:grocery_app/logic/checkout_cubit/checkout_cubit.dart';
import 'package:grocery_app/presentation/checkout/widgets/address/choose_address_body.dart';
import 'package:grocery_app/presentation/checkout/widgets/custom_stepper.dart';
import 'package:grocery_app/presentation/checkout/widgets/payment/payment_body.dart';
import 'package:grocery_app/presentation/checkout/widgets/oder_success_body.dart';

class CheckoutBody extends StatelessWidget {
  const CheckoutBody({super.key});
  final List<Widget> stepsBody = const [
    ChooseAddressBody(),
    PaymentBody(),
    OrderSuccessBody()
  ];
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AddressesCubit>(context).getAddresses();
    BlocProvider.of<CheckoutCubit>(context).makeOrderData(context);
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      buildWhen: (previous, current) => current is CheckoutChangeStep,
      builder: (context, state) {
        return Column(
          children: [
            CustomStepper(
              titles: [
                S.of(context).addressC,
                S.of(context).paymentC,
                S.of(context).successC,
              ],
              currentStep: BlocProvider.of<CheckoutCubit>(context).currentStep,
            ),
            Expanded(
                child: stepsBody[
                    BlocProvider.of<CheckoutCubit>(context).currentStep])
          ],
        );
      },
    );
  }
}
