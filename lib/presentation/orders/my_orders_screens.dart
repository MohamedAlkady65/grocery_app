import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/logic/orders_cubit/orders_cubit.dart';
import 'package:grocery_app/presentation/components/check_connection.dart';
import 'package:grocery_app/presentation/components/custom_app_bar.dart';
import 'package:grocery_app/presentation/orders/widgets/my_orders_body.dart';
import 'package:grocery_app/constants/style.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});
  static const String id = "MyOrdersScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundSecondry,
      appBar: CustomAppBar(
        title: S.of(context).myOrders,
      ),
      body: BlocProvider(
        create: (context) => OrdersCubit(),
        child: const CheckConnection(child: MyOrdersBody()),
      ),
    );
  }
}
