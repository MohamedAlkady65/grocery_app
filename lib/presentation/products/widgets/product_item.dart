import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/constants/const.dart';
import 'package:grocery_app/data/models/product_model.dart';
import 'package:grocery_app/helper/debouncer.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:grocery_app/helper/old_cart_value.dart';
import 'package:grocery_app/logic/products_cubit/products_cubit.dart';
import 'package:grocery_app/presentation/product_details/product_details_screen.dart';
import 'package:grocery_app/presentation/products/widgets/cart_product_button.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/presentation/products/widgets/favorite_product_button.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key, required this.product});
  final ProductModel product;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  final Debouncer favoriteDebouncer =
      Debouncer(milliseconds: kDebouncerDurationInMilliSecond);
  final Debouncer cartDebouncer =
      Debouncer(milliseconds: kDebouncerDurationInMilliSecond);
  OldCartValue oldCartValue = OldCartValue();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      buildWhen: (previous, current) =>
          current is ChangingProductState &&
          current.productId == widget.product.id,
      builder: (context, state) {
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: MyColors.backgroundPrimary,
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: itemOnTap,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 16),
                                child: Center(
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: getImage()),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              stringPrice(widget.product.price),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                  height: 1,
                                  color: MyColors.primaryDark,
                                  fontWeight: MyFontWeights.medium,
                                  fontSize: 12),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              widget.product.title,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                  height: 1.2,
                                  color: MyColors.text,
                                  fontWeight: MyFontWeights.semiBold,
                                  fontSize: 14),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              widget.product.quantity,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                  height: 1,
                                  color: MyColors.textSecondry,
                                  fontWeight: MyFontWeights.medium,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: MyColors.grey,
                    thickness: 0,
                    height: 0,
                  ),
                  CartProductButton(
                    product: widget.product,
                    cartDebouncer: cartDebouncer,
                    oldCartValue: oldCartValue,
                  )
                ],
              ),
            ),
            FavoriteProductButton(
                product: widget.product, favoriteDebouncer: favoriteDebouncer)
          ],
        );
      },
    );
  }

  void itemOnTap() async {
    final productsCubit = BlocProvider.of<ProductsCubit>(context);
    setProductDetailsValue(productsCubit);
    await Navigator.pushNamed(context, ProductDetailsScreen.id,
        arguments: widget.product);
    oldCartValue.value =
        productsCubit.oldCartValueInProductDetails ?? oldCartValue.value;
    resetProductDetailsValue(productsCubit);
  }

  void resetProductDetailsValue(ProductsCubit productsCubit) {
    productsCubit.favoritesDebouncerInProductDetails =
        productsCubit.cartDebouncerInProductDetails =
            productsCubit.oldCartValueInProductDetails = null;
  }

  void setProductDetailsValue(ProductsCubit productsCubit) {
    productsCubit.favoritesDebouncerInProductDetails = favoriteDebouncer;
    productsCubit.cartDebouncerInProductDetails = cartDebouncer;
    productsCubit.oldCartValueInProductDetails = oldCartValue.value;
  }

  Widget getImage() {
    final ImageProduct defaultImg =
        widget.product.images.firstWhere((element) => element.isDefault);

    return imageIsSvg(defaultImg.imgUrl)
        ? SvgPicture.network(
            defaultImg.imgUrl,
            height: double.infinity,
            fit: BoxFit.contain,
          )
        : Image.network(
            defaultImg.imgUrl,
            height: double.infinity,
            fit: BoxFit.contain,
          );
  }
}
