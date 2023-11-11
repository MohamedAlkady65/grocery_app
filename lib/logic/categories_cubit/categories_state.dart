part of 'categories_cubit.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesPageSate extends CategoriesState {}
final class CategoriesHomeSate extends CategoriesState {}


final class CategoriesSuccess extends CategoriesPageSate {
  final List<CategoryModel> categories;
  CategoriesSuccess(this.categories);
}
final class Categoriesloading extends CategoriesPageSate {}
final class CategoriesFailure extends CategoriesPageSate {
  CategoriesFailure(BuildContext context) {
    showErrorSnackBar(context);
  }
}


final class CategoriesAtHomeSuccess extends CategoriesHomeSate {
  final List<CategoryModel> categories;
  CategoriesAtHomeSuccess(this.categories);
}
final class CategoriesAtHomeloading extends CategoriesHomeSate {}
final class CategoriesAtHomeFailure extends CategoriesHomeSate {
  CategoriesAtHomeFailure(BuildContext context) {
    showErrorSnackBar(context);
  }
}
