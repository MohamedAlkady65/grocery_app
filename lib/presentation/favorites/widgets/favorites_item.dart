import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/data/models/product_model.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:grocery_app/logic/favorites_cubit/favorites_cubit.dart';
import 'package:grocery_app/logic/products_cubit/products_cubit.dart';
import 'package:grocery_app/presentation/product_details/product_details_screen.dart';

class FavoritesItem extends StatelessWidget {
  const FavoritesItem({super.key, required this.product});
  final ProductModel product;
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
              onPressed: deleteFavoriteProduct,
              backgroundColor: MyColors.redDelete,
              foregroundColor: MyColors.backgroundPrimary,
              icon: FontAwesomeIcons.solidTrashCan,
            )
          ]),
      child: InkWell(
        onTap: () {
          itemOnTap(context);
        },
        child: Container(
          decoration: BoxDecoration(
              color: MyColors.backgroundPrimary,
              borderRadius: BorderRadius.circular(6)),
          padding: const EdgeInsets.symmetric(horizontal: 8),
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
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          color: MyColors.text,
                          fontWeight: MyFontWeights.semiBold,
                          fontSize: 18),
                    ),
                    Text(
                      product.quantity,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          color: MyColors.textSecondry,
                          fontWeight: MyFontWeights.medium,
                          fontSize: 16),
                    ),
                    Text(
                      stringPrice(product.price),
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
              const Icon(
                Icons.favorite,
                color: MyColors.red,
                size: 40,
              ),
              const SizedBox(
                width: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  void itemOnTap(BuildContext context) async {
    await Navigator.pushNamed(context, ProductDetailsScreen.id,
        arguments: product);

    if (context.mounted) {
      refreshAfterProductDetails(context);
    }
  }

  void refreshAfterProductDetails(BuildContext context) {
    bool isFavorite = BlocProvider.of<ProductsCubit>(context)
        .favoriteProducts
        .contains(product.id);
    if (!isFavorite) {
      BlocProvider.of<FavoritesCubit>(context)
          .deleteFavoriteInUI(productId: product.id);
    }
  }

  void deleteFavoriteProduct(BuildContext context) {
    BlocProvider.of<FavoritesCubit>(context).deleteFavoriteProduct(
      productId: product.id,
    );
  }

  Widget getImage() {
    final ImageProduct defaultImg =
        product.images.firstWhere((element) => element.isDefault);

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
}
