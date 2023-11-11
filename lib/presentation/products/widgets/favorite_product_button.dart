import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/data/models/product_model.dart';
import 'package:grocery_app/helper/debouncer.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:grocery_app/logic/products_cubit/products_cubit.dart';

class FavoriteProductButton extends StatelessWidget {
  const FavoriteProductButton(
      {super.key, required this.product, required this.favoriteDebouncer});
  final ProductModel product;
  final Debouncer favoriteDebouncer;
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 0,
        right: isArabic() ? null : 0,
        left: isArabic() ? 0 : null,
        child: SizedBox(
            height: 35,
            width: 35,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(99999),
                child: Material(
                  type: MaterialType.circle,
                  color: Colors.transparent,
                  child: IconButton(
                      iconSize: 20,
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        changeFavorite(context);
                      },
                      icon: Visibility(
                        visible: isFavorite(context),
                        replacement: const Icon(
                          Icons.favorite_border,
                          color: MyColors.textSecondry,
                        ),
                        child: const Icon(
                          Icons.favorite,
                          color: MyColors.red,
                        ),
                      )),
                ))));
  }

  void changeFavorite(BuildContext context) async {
    final productsCubit = BlocProvider.of<ProductsCubit>(context);

    bool newSate = !isFavorite(context);

    favoriteDebouncer.run(() async {
      await productsCubit.changeFavorite(
          productId: product.id, newState: newSate);

      productsCubit.favoritesDebouncers.remove(favoriteDebouncer);
    });

    if (!productsCubit.favoritesDebouncers.contains(favoriteDebouncer)) {
      productsCubit.favoritesDebouncers.add(favoriteDebouncer);
    }
    productsCubit.changeFavoriteProductInUI(
        productId: product.id, isFavorite: newSate);
  }

  bool isFavorite(BuildContext context) =>
      BlocProvider.of<ProductsCubit>(context)
          .favoriteProducts
          .contains(product.id);
}
