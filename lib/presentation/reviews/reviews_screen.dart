import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/logic/products_cubit/products_cubit.dart';
import 'package:grocery_app/logic/reviews_cubit/reviews_cubit.dart';
import 'package:grocery_app/presentation/components/check_connection.dart';
import 'package:grocery_app/presentation/components/icon_button_app_bar_action.dart';
import 'package:grocery_app/presentation/reviews/add_review_screen.dart';
import 'package:grocery_app/presentation/components/custom_app_bar.dart';
import 'package:grocery_app/presentation/reviews/widgets/reviews_body.dart';
import 'package:grocery_app/constants/style.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  static const String id = "ReviewsScreen";
  @override
  Widget build(BuildContext context) {
    ReviewsCubit reviewsCubit =
        ReviewsCubit(BlocProvider.of<ProductsCubit>(context));
    reviewsCubit.productId =
        ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      backgroundColor: MyColors.backgroundSecondry,
      appBar: CustomAppBar(
        title: S.of(context).reviews,
        actions: addReviewButton(context: context, reviewsCubit: reviewsCubit),
      ),
      body: BlocProvider(
        create: (context) => reviewsCubit,
        child: const CheckConnection(child: ReviewsBody()),
      ),
    );
  }

  List<IconButtonAppBarAction> addReviewButton(
          {required BuildContext context,
          required ReviewsCubit reviewsCubit}) =>
      [
        IconButtonAppBarAction(
          icon: Icon(
            Icons.add_circle_outline,
            color: MyColors.text,
          ),
          onPressed: () {
            Navigator.pushNamed(context, AddReviewScreen.id,
                arguments: reviewsCubit);
          },
        )
      ];
}
