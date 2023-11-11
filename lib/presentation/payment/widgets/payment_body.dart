import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:grocery_app/logic/payment_cubit/payment_cubit.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreenBody extends StatelessWidget {
  const PaymentScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PaymentCubit>(context).init();
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is PaymentPageFailure) {
          showErrorSnackBar(context);
          Navigator.pop(context);
        } else if (state is PaymentPageDoneTransaction) {
          Navigator.pop(context, state.paymentResponse);
        }
      },
      builder: (context, state) {
        if (state is PaymentPageLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return WebViewWidget(
              controller: BlocProvider.of<PaymentCubit>(context).controller);
        }
      },
    );
  }
}
