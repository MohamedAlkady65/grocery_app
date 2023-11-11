import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/logic/categories_cubit/categories_cubit.dart';
import 'package:grocery_app/logic/landing_cubit/landing_cubit.dart';
import 'package:grocery_app/presentation/home/widgets/home_view.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CategoriesCubit()),
        BlocProvider(
          create: (context) => LandingCubit(),
        ),
      ],
      child: const HomeView(),
    );
  }
}
