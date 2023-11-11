import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/data/models/product_model.dart';
import 'package:grocery_app/helper/debouncer.dart';
import 'package:grocery_app/helper/old_cart_value.dart';
import 'package:grocery_app/logic/products_cubit/products_cubit.dart';
import 'package:grocery_app/presentation/products/widgets/add_to_cart_button.dart';
import 'package:grocery_app/presentation/products/widgets/product_cart_counter.dart';

class CartProductButton extends StatelessWidget {
  const CartProductButton(
      {super.key,
      required this.product,
      required this.cartDebouncer,
      required this.oldCartValue});
  final ProductModel product;
  final Debouncer cartDebouncer;
  final OldCartValue oldCartValue;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Visibility(
        visible: cartCount(context) == 0,
        replacement: ProductCartCounter(
          counter: cartCount(context),
          increaseOnTap: () {
            changeCartItemCount(context, 1);
          },
          decreaseOnTap: () {
            changeCartItemCount(context, -1);
          },
        ),
        child: AddToCartButton(
          onTap: () {
            changeCartItemCount(context, 1);
          },
        ),
      ),
    );
  }

  Future<void> changeCartItemCount(BuildContext context, int value) async {
    final productsCubit = BlocProvider.of<ProductsCubit>(context);

    int cartValue = cartCount(context);

    if (!cartDebouncer.isActive) {
      oldCartValue.value = cartValue;
    }

    cartValue += value;

    cartDebouncer.run(() async {
      await productsCubit.changeCartItemCount(
          productId: product.id,
          newValue: cartValue,
          oldValue: oldCartValue.value!);

      if (!cartDebouncer.isActive) {
        oldCartValue.value = null;
      }

      productsCubit.cartDebouncers.remove(cartDebouncer);
    });

    if (!productsCubit.cartDebouncers.contains(cartDebouncer)) {
      productsCubit.cartDebouncers.add(cartDebouncer);
    }

    productsCubit.changeCartItemCountInUI(
        productId: product.id, count: cartValue);
  }

  int cartCount(BuildContext context) =>
      BlocProvider.of<ProductsCubit>(context)
          .cartItems
          .firstWhereOrNull((element) => element.productId == product.id)
          ?.count ??
      0;
}
