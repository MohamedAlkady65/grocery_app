import 'package:flutter/material.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/presentation/checkout/widgets/payment/choose_payment_method.dart';
import 'package:grocery_app/presentation/checkout/widgets/payment/payment_sheet.dart';

class PaymentBody extends StatelessWidget {
  const PaymentBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).paymentMethod,
                style: TextStyle(
                    fontSize: 20,
                    color: MyColors.text,
                    fontWeight: MyFontWeights.medium),
              ),
              const SizedBox(
                height: 10,
              ),
              const ChoosePaymentMethod(),
            ],
          ),
        ),
        const Spacer(),
        const PaymentSheet()
      ],
    );
  }
}
