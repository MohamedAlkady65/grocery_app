import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/data/models/order_model.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/logic/orders_cubit/orders_cubit.dart';
import 'package:grocery_app/presentation/components/check_connection.dart';
import 'package:grocery_app/presentation/components/custom_app_bar.dart';
import 'package:grocery_app/presentation/order_details/widgets/order_details_body.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  static const String id = "OrderDetailsScreen";
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as ({
      OrdersCubit cubit,
      OrderModel order
    });
    return Scaffold(
      backgroundColor: MyColors.backgroundSecondry,
      appBar:  CustomAppBar(
        title:  S.of(context).order,
      ),
      body: BlocProvider.value(
        value: arguments.cubit,
        child: CheckConnection(
          child: OrderDetailsBody(
            order: arguments.order,
          ),
        ),
      ),
    );
  }
}
