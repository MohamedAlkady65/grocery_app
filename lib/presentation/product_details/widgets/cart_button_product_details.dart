import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/constants/const.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/data/models/product_model.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/helper/debouncer.dart';
import 'package:grocery_app/logic/products_cubit/products_cubit.dart';
import 'package:grocery_app/presentation/components/bright_button.dart';
import 'package:grocery_app/presentation/product_details/widgets/counter_addto_cart_product_details.dart';

class CartButtonProductDetails extends StatefulWidget {
  const CartButtonProductDetails({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  State<CartButtonProductDetails> createState() =>
      _CartButtonProductDetailsState();
}

class _CartButtonProductDetailsState extends State<CartButtonProductDetails> {
  late Debouncer cartDebouncer;

  @override
  void initState() {
    cartDebouncer =
        BlocProvider.of<ProductsCubit>(context).cartDebouncerInProductDetails ??
            Debouncer(milliseconds: kDebouncerDurationInMilliSecond);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      buildWhen: (previous, current) =>
          current is ChangingProductState &&
          current.productId == widget.product.id,
      builder: (context, state) {
        return Visibility(
          visible: cartCount == 0,
          replacement: CounterAddtoCartProductDetails(
            increaseOnTap: () {
              changeCartItemCount(1);
            },
            decreaseOnTap: () {
              changeCartItemCount(-1);
            },
            counter: cartCount,
          ),
          child: BrightButton(
            text:  S.of(context).addToCart,
            icon: SvgPicture.asset(
              "assets/images/cart_icon_white.svg",
              color: MyColors.backgroundPrimary,
            ),
            onTap: () async {
              await changeCartItemCount(1);
            },
            left: false,
          ),
        );
      },
    );
  }

  Future<void> changeCartItemCount(int value) async {
    final productsCubit = BlocProvider.of<ProductsCubit>(context);

    int cartValue = cartCount;

    if (!cartDebouncer.isActive) {
      productsCubit.oldCartValueInProductDetails = cartValue;
    }

    cartValue += value;

    int oldValue = productsCubit.oldCartValueInProductDetails!;
    cartDebouncer.run(() async {
      await productsCubit.changeCartItemCount(
          productId: widget.product.id,
          newValue: cartValue,
          oldValue: oldValue);

      productsCubit.cartDebouncers.remove(cartDebouncer);
    });

    if (!productsCubit.cartDebouncers.contains(cartDebouncer)) {
      productsCubit.cartDebouncers.add(cartDebouncer);
    }

    productsCubit.changeCartItemCountInUI(
        productId: widget.product.id, count: cartValue);
  }

  int get cartCount =>
      BlocProvider.of<ProductsCubit>(context)
          .cartItems
          .firstWhereOrNull((element) => element.productId == widget.product.id)
          ?.count ??
      0;
}
