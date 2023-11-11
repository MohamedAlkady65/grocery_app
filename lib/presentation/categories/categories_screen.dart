import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/logic/categories_cubit/categories_cubit.dart';

import 'package:grocery_app/presentation/categories/widgets/category_screen_body.dart';
import 'package:grocery_app/presentation/components/check_connection.dart';
import 'package:grocery_app/presentation/components/custom_app_bar.dart';
import 'package:grocery_app/constants/style.dart';

class CategiriesScreen extends StatelessWidget {
  const CategiriesScreen({super.key});
  static const String id = "CategiriesScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundSecondry,
      appBar:  CustomAppBar(
        title: S.of(context).categories,
      ),
      body: BlocProvider(
        create: (context) => CategoriesCubit(),
        child: const CheckConnection(child: CategoriesBody()),
      ),
    );
  }
}
