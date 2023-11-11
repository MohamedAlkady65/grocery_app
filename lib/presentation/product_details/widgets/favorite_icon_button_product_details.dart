import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/constants/const.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/data/models/product_model.dart';
import 'package:grocery_app/helper/debouncer.dart';
import 'package:grocery_app/logic/products_cubit/products_cubit.dart';

class FavoriteIconButtonProductDetails extends StatefulWidget {
  const FavoriteIconButtonProductDetails({super.key, required this.product});
  final ProductModel product;

  @override
  State<FavoriteIconButtonProductDetails> createState() =>
      _FavoriteIconButtonProductDetailsState();
}

class _FavoriteIconButtonProductDetailsState
    extends State<FavoriteIconButtonProductDetails> {
  late Debouncer favoriteDebouncer;

  @override
  void initState() {
    favoriteDebouncer = BlocProvider.of<ProductsCubit>(context)
            .favoritesDebouncerInProductDetails ??
        Debouncer(milliseconds: kDebouncerDurationInMilliSecond);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                  onPressed: changeFavorite,
                  icon: BlocBuilder<ProductsCubit, ProductsState>(
                    buildWhen: (previous, current) =>
                        current is ChangingProductState &&
                        current.productId == widget.product.id,
                    builder: (context, state) {
                      return Visibility(
                        visible: isFavorite,
                        replacement: const Icon(
                          Icons.favorite_border,
                          color: MyColors.textSecondry,
                        ),
                        child: const Icon(
                          Icons.favorite,
                          color: MyColors.red,
                        ),
                      );
                    },
                  )),
            )));
  }

  void changeFavorite() async {
    final productsCubit = BlocProvider.of<ProductsCubit>(context);

    bool newSate = !isFavorite;

    favoriteDebouncer.run(() async {
      await productsCubit.changeFavorite(
          productId: widget.product.id, newState: newSate);

      productsCubit.favoritesDebouncers.remove(favoriteDebouncer);
    });

    if (!productsCubit.favoritesDebouncers.contains(favoriteDebouncer)) {
      productsCubit.favoritesDebouncers.add(favoriteDebouncer);
    }
    productsCubit.changeFavoriteProductInUI(
        productId: widget.product.id, isFavorite: newSate);
  }

  bool get isFavorite => BlocProvider.of<ProductsCubit>(context)
      .favoriteProducts
      .contains(widget.product.id);
}
