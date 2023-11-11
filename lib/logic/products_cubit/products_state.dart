part of 'products_cubit.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

final class FeaturedProductsState extends ProductsState {}

final class FeaturedProductsAtHomeState extends ProductsState {}

final class CategoryProductsState extends ProductsState {}

////////////////////////////////////////////////////////////////////////////

final class FeaturedProductsSuccess extends FeaturedProductsState {}

final class FeaturedProductsLoading extends FeaturedProductsState {}

final class FeaturedProductsFailure extends FeaturedProductsState {}

////////////////////////////////////////////////////////////////////////////

final class FeaturedProductsAtHomeSuccess extends FeaturedProductsAtHomeState {}

final class FeaturedProductsAtHomeLoading extends FeaturedProductsAtHomeState {}

final class FeaturedProductsAtHomeFailure extends FeaturedProductsAtHomeState {}

////////////////////////////////////////////////////////////////////////////

final class CategoryProductsSuccess extends CategoryProductsState {}

final class CategoryProductsLoading extends CategoryProductsState {}

final class CategoryProductsFailure extends CategoryProductsState {}

/////////////////////////////////////////////////////////////////////////

final class ChangingProductState extends ProductsState {
  final String productId;

  ChangingProductState(this.productId);
}

/////////////////////////////////////////////////////////////////////////


