import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/logic/categories_cubit/categories_cubit.dart';
import 'package:grocery_app/presentation/categories/widgets/category_item.dart';

class CategoriesHomeListView extends StatelessWidget {
  const CategoriesHomeListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: BlocBuilder<CategoriesCubit, CategoriesState>(
        buildWhen: (previous, current) => current is CategoriesHomeSate,
        builder: (context, state) {
          if (state is CategoriesAtHomeloading) {
            return  const Center(
              child: CircularProgressIndicator(),
            );
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
    );
  }
}
