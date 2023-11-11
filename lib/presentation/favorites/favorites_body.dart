import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/logic/favorites_cubit/favorites_cubit.dart';
import 'package:grocery_app/presentation/favorites/widgets/favorites_view.dart';

class FavoritesBody extends StatelessWidget {
  const FavoritesBody({super.key, required this.favoritesCubit});
  final FavoritesCubit favoritesCubit;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: favoritesCubit,
      child: const FavoritesView(),
    );
  }
}
