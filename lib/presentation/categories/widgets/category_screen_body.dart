import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/logic/categories_cubit/categories_cubit.dart';
import 'package:grocery_app/presentation/categories/widgets/categories_loading.dart';
import 'package:grocery_app/presentation/categories/widgets/category_item.dart';
import 'package:grocery_app/constants/style.dart';

class CategoriesBody extends StatelessWidget {
  const CategoriesBody({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CategoriesCubit>(context).getCategories(context);

    return BlocBuilder<CategoriesCubit, CategoriesState>(
      buildWhen: (previous, current) => current is CategoriesPageSate,
      builder: (context, state) {
        if (state is Categoriesloading) {
          return const CategoriesLoading();
        } else if (state is CategoriesSuccess) {
          var categories = state.categories;
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 120,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10),
            itemCount: categories.length,
            itemBuilder: (context, index) => CategoryItem(
              category: categories[index],
              backgroundColor: MyColors.backgroundPrimary,
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
