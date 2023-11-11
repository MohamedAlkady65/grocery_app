import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:grocery_app/logic/cart_cubit/cart_cubit.dart';
import 'package:grocery_app/presentation/cart/widgets/cart_body.dart';
import 'package:grocery_app/presentation/components/check_connection.dart';
import 'package:grocery_app/presentation/components/custom_app_bar.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/presentation/components/icon_button_app_bar_action.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  static const String id = "CartScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundSecondry,
      appBar: CustomAppBar(
        title: S.of(context).shoppingCart,
        actions: [clearCartButton(context)],
      ),
      body: const CheckConnection(child: CartBody()),
    );
  }

  BlocBuilder clearCartButton(BuildContext context) =>
      BlocBuilder<CartCubit, CartState>(
        buildWhen: (previous, current) => current is CartLoadItemsState,
        builder: (context, state) {
          if (state is CartItemsSuccess &&
              BlocProvider.of<CartCubit>(context).cartItems.isNotEmpty) {
            return IconButtonAppBarAction(
              icon: Icon(
                FontAwesomeIcons.solidTrashCan,
                color: MyColors.text,
                size: 20,
              ),
              onPressed: () {
                showSuringDIalog(
                  context: context,
                  title: S.of(context).deleteCart,
                  content: S.of(context).SureToDeleteCart,
                  okCallBack: () async {
                    Navigator.pop(context);

                    showLoadingDIalog(context);

                    await BlocProvider.of<CartCubit>(context).clearCartButton();

                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                );
              },
            );
          } else {
            return const SizedBox();
          }
        },
      );
}
