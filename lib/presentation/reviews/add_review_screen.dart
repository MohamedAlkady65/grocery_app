import 'package:flutter/material.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/logic/reviews_cubit/reviews_cubit.dart';
import 'package:grocery_app/presentation/components/check_connection.dart';
import 'package:grocery_app/presentation/reviews/widgets/add_review_body.dart';
import 'package:grocery_app/presentation/components/custom_app_bar.dart';
import 'package:grocery_app/constants/style.dart';

class AddReviewScreen extends StatelessWidget {
  const AddReviewScreen({super.key});
  static const String id = "AddReviewScreen";

  @override
  Widget build(BuildContext context) {
    ReviewsCubit reviewsCubit =
        ModalRoute.of(context)!.settings.arguments as ReviewsCubit;
    return Scaffold(
      backgroundColor: MyColors.backgroundSecondry,
      appBar:  CustomAppBar(
        title:  S.of(context).addReview,
      ),
      body:   CheckConnection(
        child: AddReviewBody(
          reviewsCubit: reviewsCubit,
        ),
      ),
    );
  }
}
