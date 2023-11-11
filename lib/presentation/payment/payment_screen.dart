import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/data/models/payment_invoice_model.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/logic/payment_cubit/payment_cubit.dart';
import 'package:grocery_app/presentation/components/check_connection.dart';
import 'package:grocery_app/presentation/components/custom_app_bar.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/presentation/payment/widgets/payment_body.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});
  static const String id = "PaymentScreen";
  @override
  Widget build(BuildContext context) {
    PaymentInvoiceModel paymentInvoice =
        ModalRoute.of(context)!.settings.arguments as PaymentInvoiceModel;
    return Scaffold(
      backgroundColor: MyColors.backgroundSecondry,
      appBar: CustomAppBar(
        title: S.of(context).paymentS,
      ),
      body: BlocProvider(
        create: (context) => PaymentCubit(paymentInvoice: paymentInvoice),
        child: const CheckConnection(child: PaymentScreenBody()),
      ),
    );
  }
}
