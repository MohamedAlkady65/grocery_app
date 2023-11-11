part of 'reviews_cubit.dart';

@immutable
sealed class ReviewsState {}

final class ReviewsInitial extends ReviewsState {}

final class ReviewsStars extends ReviewsState {}

final class ReviewsGetState extends ReviewsState {}
final class ReviewsAddState extends ReviewsState {}

final class ReviewsAddSuccess extends ReviewsAddState {}

final class ReviewsAddLoading extends ReviewsAddState {}

final class ReviewsAddFailure extends ReviewsAddState {}

final class ReviewsEmptyStars extends ReviewsStars {}

final class ReviewsNotEmptyStars extends ReviewsStars {}

final class ReviewsGetLoading extends ReviewsGetState {}

final class ReviewsGetSuccess extends ReviewsGetState {
}

final class ReviewsGetFailure extends ReviewsGetState {}
