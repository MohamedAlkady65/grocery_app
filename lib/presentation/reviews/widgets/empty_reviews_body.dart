import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/logic/reviews_cubit/reviews_cubit.dart';
import 'package:grocery_app/presentation/components/bright_button.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/presentation/reviews/add_review_screen.dart';

class EmptyReviewsBody extends StatelessWidget {
  const EmptyReviewsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        children: [
          const Spacer(
            flex: 1,
          ),
          Center(
            child: Column(
              children: [
                const Icon(
                  Icons.reviews_outlined,
                  size: 170,
                  color: MyColors.primaryDark,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  S.of(context).noReviewsYet,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: MyFontWeights.semiBold,
                      color: MyColors.text),
                )
              ],
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          BrightButton(
            text: S.of(context).writeAReview,
            onTap: () {
              Navigator.pushNamed(context, AddReviewScreen.id,
                  arguments: BlocProvider.of<ReviewsCubit>(context));
            },
          )
        ],
      ),
    );
  }
}
