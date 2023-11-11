import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:grocery_app/logic/products_cubit/products_cubit.dart';
import 'package:grocery_app/presentation/products/widgets/products_body.dart';
import 'package:grocery_app/presentation/products/widgets/products_loading.dart';

class FeaturedProductsBody extends StatelessWidget {
  const FeaturedProductsBody({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductsCubit>(context).getFeaturedProducts();

    return BlocConsumer<ProductsCubit, ProductsState>(
      listenWhen: (previous, current) => current is FeaturedProductsState,
      listener: (context, state) {
        if (state is FeaturedProductsFailure) {
          showErrorSnackBar(context);
        }
      },
      buildWhen: (previous, current) => current is FeaturedProductsState,
      builder: (context, state) {
        if (state is FeaturedProductsLoading) {
          return const ProductsLoading(
            padding: EdgeInsets.all(16),
          );
        } else if (state is FeaturedProductsSuccess) {
          return ProductsBody(
            padding: const EdgeInsets.all(16),
            products: BlocProvider.of<ProductsCubit>(context).featuredProducts,
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
