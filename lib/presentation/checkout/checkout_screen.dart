import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/logic/cart_cubit/cart_cubit.dart';
import 'package:grocery_app/logic/checkout_cubit/checkout_cubit.dart';
import 'package:grocery_app/presentation/checkout/widgets/checkout_body.dart';
import 'package:grocery_app/presentation/components/check_connection.dart';
import 'package:grocery_app/presentation/components/custom_app_bar.dart';
import 'package:grocery_app/constants/style.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});
  static const String id = "CheckoutScreen";
  @override
  Widget build(BuildContext context) {
    CartCubit cartCubit =
        ModalRoute.of(context)!.settings.arguments as CartCubit;
    return WillPopScope(
      onWillPop: () async {
        back(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: MyColors.backgroundSecondry,
        appBar: CustomAppBar(
          title: S.of(context).checkout,
          backIconFunction: () {
            back(context);
          },
        ),
        body: BlocProvider.value(
          value: cartCubit,
          child: const CheckConnection(child: CheckoutBody()),
        ),
      ),
    );
  }

  void back(BuildContext context) {
    BlocProvider.of<CheckoutCubit>(context).previousStep(context);
  }
}
