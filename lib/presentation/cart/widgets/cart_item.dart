import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocery_app/constants/const.dart';
import 'package:grocery_app/data/models/cart_item_model.dart';
import 'package:grocery_app/data/models/product_model.dart';
import 'package:grocery_app/helper/debouncer.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:grocery_app/helper/old_cart_value.dart';
import 'package:grocery_app/logic/cart_cubit/cart_cubit.dart';
import 'package:grocery_app/logic/products_cubit/products_cubit.dart';
import 'package:grocery_app/presentation/cart/widgets/counter_cart_item.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/presentation/product_details/product_details_screen.dart';

class CartItem extends StatefulWidget {
  const CartItem({super.key, required this.item});
  final CartItemModel item;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late Debouncer cartDebouncer;
  late OldCartValue oldCartValue;

  @override
  void initState() {
    cartDebouncer = Debouncer(milliseconds: kDebouncerDurationInMilliSecond);
    oldCartValue = OldCartValue();
    oldCartValue.value = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      groupTag: 1,
      endActionPane: ActionPane(
          extentRatio: 0.20,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              autoClose: true,
              onPressed: deleteCartItem,
              backgroundColor: MyColors.redDelete,
              foregroundColor: MyColors.backgroundPrimary,
              icon: FontAwesomeIcons.solidTrashCan,
            )
          ]),
      child: InkWell(
        onTap: itemOnTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: MyColors.backgroundPrimary,
          ),
          height: 100,
          child: Row(
            children: [
              Container(
                width: 100,
                padding: const EdgeInsets.all(8),
                height: double.infinity,
                child: Center(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: getImage())),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.product.title,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          color: MyColors.text,
                          fontWeight: MyFontWeights.semiBold,
                          fontSize: 18),
                    ),
                    Text(
                      widget.item.product.quantity,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          color: MyColors.textSecondry,
                          fontWeight: MyFontWeights.medium,
                          fontSize: 14),
                    ),
                    Text(
                      "\$${widget.item.product.price.toStringAsFixed(2)} x ${widget.item.count}",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          color: MyColors.primary,
                          fontWeight: MyFontWeights.medium,
                          fontSize: 12),
                    ),
                    Text(
                      stringPrice(
                          widget.item.product.price * widget.item.count),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          color: MyColors.primaryDark,
                          fontWeight: MyFontWeights.medium,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              CounterCartItem(
                count: widget.item.count,
                increaseOnTap: () {
                  changeCartItemCount(context, 1);
                },
                decreaseOnTap: widget.item.count == 1
                    ? () {
                        deleteCartItem(context);
                      }
                    : () {
                        changeCartItemCount(context, -1);
                      },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getImage() {
    final ImageProduct defaultImg =
        widget.item.product.images.firstWhere((element) => element.isDefault);

    return imageIsSvg(defaultImg.imgUrl)
        ? SvgPicture.network(
            defaultImg.imgUrl,
            height: double.infinity,
            fit: BoxFit.fitWidth,
          )
        : Image.network(
            defaultImg.imgUrl,
            height: double.infinity,
            fit: BoxFit.fitWidth,
          );
  }

  void itemOnTap() async {
    final productsCubit = BlocProvider.of<ProductsCubit>(context);
    final cartCubit = BlocProvider.of<CartCubit>(context);
    setProductDetailsValue(productsCubit);
    await Navigator.pushNamed(context, ProductDetailsScreen.id,
        arguments: widget.item.product);

    refreshAfterProductDetails(productsCubit, cartCubit);

    oldCartValue.value =
        productsCubit.oldCartValueInProductDetails ?? oldCartValue.value;
    resetProductDetailsValue(productsCubit);
  }

  void refreshAfterProductDetails(
      ProductsCubit productsCubit, CartCubit cartCubit) {
    int currentCount = productsCubit.cartItems
            .firstWhereOrNull(
                (element) => element.productId == widget.item.product.id)
            ?.count ??
        0;
    if (currentCount != widget.item.count) {
      if (currentCount == 0) {
        cartCubit.deleteCartItemInUI(productId: widget.item.product.id);
      } else {
        setState(() {
          widget.item.count = currentCount;
        });
      }
      cartCubit.changingTotalPrice();
    }
  }

  void resetProductDetailsValue(ProductsCubit productsCubit) {
    productsCubit.cartDebouncerInProductDetails =
        productsCubit.oldCartValueInProductDetails = null;
  }

  void setProductDetailsValue(ProductsCubit productsCubit) {
    productsCubit.cartDebouncerInProductDetails = cartDebouncer;
    productsCubit.oldCartValueInProductDetails = oldCartValue.value;
  }

  void changeCartItemCount(BuildContext context, int value) async {
    final cartCubit = BlocProvider.of<CartCubit>(context);
    final productsCubit = BlocProvider.of<ProductsCubit>(context);

    setState(() {
      widget.item.count += value;
    });

    oldCartValue.value = oldCartValue.value! + value;

    cartDebouncer.run(() async {
      await cartCubit.changeCartItemCount(
          productId: widget.item.product.id,
          newValue: widget.item.count,
          onError: () {
            if (context.mounted) {
              setState(() {
                widget.item.count -= oldCartValue.value!;
              });
            }
          },
          value: oldCartValue.value!);

      oldCartValue.value = 0;
    });

    cartCubit.changingTotalPrice();
    productsCubit.changeCartItemCountInUI(
        productId: widget.item.product.id, count: widget.item.count);
  }

  void deleteCartItem(BuildContext context) async {
    BlocProvider.of<CartCubit>(context).deleteCartItem(
      productId: widget.item.product.id,
    );
  }
}
