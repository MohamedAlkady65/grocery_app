import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:grocery_app/data/models/product_model.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:grocery_app/logic/favorites_cubit/favorites_cubit.dart';
import 'package:grocery_app/presentation/favorites/widgets/empty_favorites.dart';
import 'package:grocery_app/presentation/favorites/widgets/favorites_item.dart';
import 'package:grocery_app/presentation/favorites/widgets/favorites_loading.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FavoritesCubit>(context).getFavoritesProducts();
    return BlocConsumer<FavoritesCubit, FavoritesState>(
      listener: (context, state) {
        if (state is FavoriteProductsFailure) {
          showErrorSnackBar(context);
        }
      },
      builder: (context, state) {
        if (state is FavoriteProductsLoading) {
          return const FavoritesLoading();
        } else if (state is FavoriteProductsSuccess) {
          List<ProductModel> favoritesProducts =
              BlocProvider.of<FavoritesCubit>(context).favoritesProducts;
          if (favoritesProducts.isEmpty) {
            return const EmptyFavorites();
          } else {
            return SlidableAutoCloseBehavior(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: favoritesProducts.length,
                itemBuilder: (context, index) => FavoritesItem(
                  product: favoritesProducts[index],
                ),
              ),
            );
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
