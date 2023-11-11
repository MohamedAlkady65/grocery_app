import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/constants/enums.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:grocery_app/logic/checkout_cubit/checkout_cubit.dart';
import 'package:grocery_app/presentation/components/bright_button.dart';

class PaymentSheet extends StatelessWidget {
  const PaymentSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: MyColors.backgroundPrimary, boxShadow: [
        BoxShadow(
          blurStyle: BlurStyle.normal,
          blurRadius: 10,
          color: MyColors.text.withOpacity(0.2),
          offset: const Offset(0, 1),
        )
      ]),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).totalPrice,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: MyFontWeights.semiBold,
                  color: MyColors.text),
            ),
            Text(
              stringPrice(BlocProvider.of<CheckoutCubit>(context).totalPrice),
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: MyFontWeights.semiBold,
                  color: MyColors.text),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).items,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: MyFontWeights.semiBold,
                  color: MyColors.text),
            ),
            Text(
              "${BlocProvider.of<CheckoutCubit>(context).orderItemsCount}",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: MyFontWeights.semiBold,
                  color: MyColors.text),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        BlocBuilder<CheckoutCubit, CheckoutState>(
          buildWhen: (previous, current) =>
              current is CheckoutChangePaymentMethod,
          builder: (context, state) {
            return BrightButton(
              text: BlocProvider.of<CheckoutCubit>(context).choosenMethod ==
                      PaymentMethod.creditCard
                  ? S.of(context).makeAPayment
                  : S.of(context).orderNow,
              onTap: () {
                BlocProvider.of<CheckoutCubit>(context).confirmButton(context);
              },
            );
          },
        )
      ]),
    );
  }
}
