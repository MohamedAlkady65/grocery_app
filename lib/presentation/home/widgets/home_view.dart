import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:grocery_app/logic/categories_cubit/categories_cubit.dart';
import 'package:grocery_app/logic/products_cubit/products_cubit.dart';
import 'package:grocery_app/presentation/categories/widgets/categories_home_loading.dart';
import 'package:grocery_app/presentation/categories/widgets/category_item.dart';
import 'package:grocery_app/presentation/home/widgets/home_section.dart';
import 'package:grocery_app/presentation/home/widgets/landing/landing.dart';
import 'package:grocery_app/presentation/products/widgets/products_body.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/presentation/categories/categories_screen.dart';
import 'package:grocery_app/presentation/products/featured_products_screen.dart';
import 'package:grocery_app/presentation/products/widgets/products_loading.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CategoriesCubit>(context).getCategoriesAtHome(context);
    BlocProvider.of<ProductsCubit>(context).getFeaturedProductsAtHome();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Landing(
              controller: PageController(),
            ),
            Container(
              height: 10,
              color: MyColors.backgroundSecondry,
            ),
            categoriesSection(context),
            Container(
              height: 10,
              color: MyColors.backgroundSecondry,
            ),
            productsSection(context),
          ],
        ),
      ),
    );
  }

  HomeSection categoriesSection(BuildContext context) {
    return HomeSection(
      title: S.of(context).categories,
      onPressed: () {
        Navigator.pushNamed(context, CategiriesScreen.id);
      },
      color: MyColors.backgroundSecondry,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 100,
        child: BlocBuilder<CategoriesCubit, CategoriesState>(
          buildWhen: (previous, current) => current is CategoriesHomeSate,
          builder: (context, state) {
            if (state is CategoriesAtHomeloading) {
              return const CategoriesHomeLoading();
            } else if (state is CategoriesAtHomeSuccess) {
              var categories = state.categories;
              return ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  width: 22,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) => CategoryItem(
                  category: categories[index],
                  backgroundColor: Colors.transparent,
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  HomeSection productsSection(BuildContext context) {
    return HomeSection(
      title: S.of(context).featuredProducts,
      onPressed: () => Navigator.pushNamed(context, FeaturedProductsScreen.id),
      color: MyColors.backgroundSecondry,
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: BlocConsumer<ProductsCubit, ProductsState>(
        listenWhen: (previous, current) =>
            current is FeaturedProductsAtHomeState,
        listener: (context, state) {
          if (state is FeaturedProductsAtHomeFailure) {
            showErrorSnackBar(context);
          }
        },
        buildWhen: (previous, current) =>
            current is FeaturedProductsAtHomeState,
        builder: (context, state) {
          if (state is FeaturedProductsAtHomeLoading) {
            return const ProductsLoading(
              padding: EdgeInsets.only(bottom: 16),
              itemCount: 4,
            );
          } else if (state is FeaturedProductsAtHomeSuccess) {
            return ProductsBody(
              padding: const EdgeInsets.only(bottom: 16),
              shrinkWrap: true,
              products: BlocProvider.of<ProductsCubit>(context)
                  .featuredProductsAtHome,
              itemsLength: 8,
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
