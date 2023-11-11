import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/data/models/review_model.dart';
import 'package:grocery_app/logic/reviews_cubit/reviews_cubit.dart';
import 'package:grocery_app/presentation/reviews/widgets/empty_reviews_body.dart';
import 'package:grocery_app/presentation/reviews/widgets/review_item.dart';
import 'package:grocery_app/presentation/reviews/widgets/reviews_loading.dart';

class ReviewsBody extends StatelessWidget {
  const ReviewsBody({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ReviewsCubit>(context).getReviews();
    return BlocBuilder<ReviewsCubit, ReviewsState>(
      buildWhen: (previous, current) => current is ReviewsGetState,
      builder: (context, state) {
        if (state is ReviewsGetLoading) {
          return const ReviewsLoading();
        } else if (state is ReviewsGetSuccess) {
          List<ReviewModel> reviews =
              BlocProvider.of<ReviewsCubit>(context).reviews;

          if (reviews.isEmpty) {
            return const EmptyReviewsBody();
          } else {
            return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  return ReviewItem(
                    review: reviews[index],
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                itemCount: reviews.length);
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
