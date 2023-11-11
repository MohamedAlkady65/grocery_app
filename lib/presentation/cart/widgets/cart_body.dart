import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:grocery_app/data/models/cart_item_model.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:grocery_app/logic/auth/otp_cubit/otp_cubit.dart';
import 'package:grocery_app/logic/cart_cubit/cart_cubit.dart';
import 'package:grocery_app/logic/info_cubit/info_cubit.dart';
import 'package:grocery_app/presentation/auth/verify_phone/send_otp_screen.dart';
import 'package:grocery_app/presentation/cart/widgets/cart_item.dart';
import 'package:grocery_app/presentation/cart/widgets/cart_loading.dart';
import 'package:grocery_app/presentation/cart/widgets/cart_sheet.dart';
import 'package:grocery_app/presentation/cart/widgets/empty_cart.dart';
import 'package:grocery_app/presentation/checkout/checkout_screen.dart';

class CartBody extends StatelessWidget {
  const CartBody({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CartCubit>(context).getCartItems();
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CartItemsFailure) {
          showErrorSnackBar(context);
        }
      },
      buildWhen: (previous, current) => current is CartLoadItemsState,
      builder: (context, state) {
        if (state is CartItemsLoading) {
          return const CartLoading();
        } else if (state is CartItemsSuccess) {
          List<CartItemModel> cartItems =
              BlocProvider.of<CartCubit>(context).cartItems;
          if (cartItems.isEmpty) {
            return const EmptyCart();
          } else {
            return Column(
              children: [
                Expanded(
                  child: SlidableAutoCloseBehavior(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(16),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) => CartItem(
                        item: cartItems[index],
                      ),
                    ),
                  ),
                ),
                BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    return CartSheet(
                      totalPrice:
                          BlocProvider.of<CartCubit>(context).totalPrice,
                      onTap: () {
                        if (BlocProvider.of<InfoCubit>(context)
                            .currentUser!
                            .phoneVerified) {
                          Navigator.pushNamed(context, CheckoutScreen.id,
                              arguments: BlocProvider.of<CartCubit>(context));
                        } else {
                          showVerifyDialog(context);
                        }
                      },
                    );
                  },
                )
              ],
            );
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }

  void showVerifyDialog(BuildContext context) {
    showSuringDIalog(
      context: context,
      title: S.of(context).verifyPhone,
      content: S.of(context).pleaseVerifyPhoneNumber,
      okText: S.of(context).verify,
      okCallBack: () {
        Navigator.pop(context);
        final infoCubit = BlocProvider.of<InfoCubit>(context);
        final phone = infoCubit.currentUser!.phone;
        OtpCubit otpCubit =
            OtpCubit(phone: phone, canSkip: false, infoCubit: infoCubit);

        Navigator.pushReplacementNamed(context, SendOTPScreen.id,
            arguments: otpCubit);
      },
    );
  }
}
