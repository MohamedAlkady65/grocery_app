import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/logic/reviews_cubit/reviews_cubit.dart';
import 'package:grocery_app/presentation/components/bright_button.dart';
import 'package:grocery_app/presentation/components/custom_text_field.dart';
import 'package:grocery_app/presentation/reviews/widgets/interactive_stars.dart';
import 'package:grocery_app/constants/style.dart';

class AddReviewBody extends StatelessWidget {
  const AddReviewBody({super.key, required this.reviewsCubit});
  final ReviewsCubit reviewsCubit;
  @override
  Widget build(BuildContext context) {
    reviewsCubit.rate = 0;
    reviewsCubit.comment = "";
    return BlocConsumer<ReviewsCubit, ReviewsState>(
      listenWhen: (previous, current) => current is ReviewsAddState,
      listener: (context, state) {
        if (state is ReviewsAddSuccess) {
          Navigator.pop(context);
        }
      },
      buildWhen: (previous, current) => current is ReviewsAddState,
      bloc: reviewsCubit,
      builder: (context, state) {
        return AbsorbPointer(
          absorbing: state is ReviewsAddLoading,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
            children: [
              Text(
                S.of(context).whatDoYouThink,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: MyFontWeights.semiBold,
                    fontSize: 20,
                    color: MyColors.text),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: Text(
                  S.of(context).pleaseGiveYourRating,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: MyFontWeights.medium,
                      fontSize: 15,
                      color: MyColors.textSecondry),
                ),
              ),
              InteractiveStarts(
                intialValue: reviewsCubit.rate,
                onChanged: (value) {
                  reviewsCubit.rate = value;
                },
              ),
              BlocBuilder<ReviewsCubit, ReviewsState>(
                bloc: reviewsCubit,
                buildWhen: (previous, current) => current is ReviewsStars,
                builder: (context, state) {
                  if (state is ReviewsEmptyStars) {
                    return Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          S.of(context).pleaseGiveUsYourRating,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: MyColors.redDelete,
                              fontSize: 14,
                              fontWeight: MyFontWeights.medium),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Form(
                  key: reviewsCubit.formKey,
                  child: CustomTextField(
                    maxLength: 150,
                    hintText: S.of(context).tellUsAboutYourExperience,
                    icon: const Icon(Icons.edit),
                    maxLines: 7,
                    onSaved: (value) {
                      reviewsCubit.comment = value ?? "";
                    },
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return S.of(context).pleaseTellUsYourComment;
                      }
                      return null;
                    },
                  ),
                ),
              ),
              BrightButton(
                isLoading: state is ReviewsAddLoading,
                text: S.of(context).sendReview,
                onTap: () {
                  reviewsCubit.addReview();
                },
              )
            ],
          ),
        );
      },
    );
  }
}
