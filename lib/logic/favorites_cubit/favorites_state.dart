part of 'favorites_cubit.dart';

@immutable
sealed class FavoritesState {}

final class FavoritesInitial extends FavoritesState {}

final class FavoriteProductsSuccess extends FavoritesState {

}

final class FavoriteProductsLoading extends FavoritesState {}

final class FavoriteProductsFailure extends FavoritesState {

}


