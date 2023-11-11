import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:grocery_app/logic/products_cubit/products_cubit.dart';
import 'package:grocery_app/presentation/products/widgets/products_body.dart';
import 'package:grocery_app/presentation/products/widgets/products_loading.dart';

class ProductsCategoryBody extends StatelessWidget {
  const ProductsCategoryBody({super.key, required this.categoryId});
  final String categoryId;
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductsCubit>(context)
        .getProductsOfCategory(categoryId: categoryId);
    return BlocConsumer<ProductsCubit, ProductsState>(
      listenWhen: (previous, current) => current is CategoryProductsState,
      listener: (context, state) {
        if (state is CategoryProductsFailure) {
          showErrorSnackBar(context);
        }
      },
      buildWhen: (previous, current) => current is CategoryProductsState,
      builder: (context, state) {
        if (state is CategoryProductsLoading) {
          return const ProductsLoading(
            padding: EdgeInsets.all(16),
          );
        } else if (state is CategoryProductsSuccess) {
          return ProductsBody(
            padding: const EdgeInsets.all(16),
            products:
                BlocProvider.of<ProductsCubit>(context).productsOfCategory,
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
