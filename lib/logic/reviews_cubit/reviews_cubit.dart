import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/constants/enums.dart';
import 'package:grocery_app/data/models/product_model.dart';
import 'package:grocery_app/data/models/review_model.dart';
import 'package:grocery_app/data/models/user_model.dart';
import 'package:grocery_app/data/services/reviews_services.dart';
import 'package:grocery_app/helper/collections.dart';
import 'package:grocery_app/logic/products_cubit/products_cubit.dart';
import 'package:grocery_app/logic/reviews_cubit/sorted_review_list.dart';
import 'package:meta/meta.dart';

part 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  ReviewsCubit(this.productsCubit) : super(ReviewsInitial());
  final ProductsCubit productsCubit;
  late String productId;
  ReviewsServices reviewsServices = ReviewsServices();
  double rate = 0;
  String comment = "";
  GlobalKey<FormState> formKey = GlobalKey();
  List<ReviewModel> reviews = [];

  void addReview() async {
    if (!formKey.currentState!.validate() || rate == 0) {
      if (rate == 0) {
        emit(ReviewsEmptyStars());
      } else {
        emit(ReviewsNotEmptyStars());
      }
      return;
    }

    formKey.currentState!.save();

    String userId = FirebaseAuth.instance.currentUser!.uid;
    emit(ReviewsAddLoading());

    final ReviewModel addingReview = ReviewModel(
        comment: comment,
        rate: rate,
        userId: userId,
        date: DateTime.now(),
        productId: productId);

    final response = await reviewsServices.addReview(addingReview);

    if (response == DataResponse.success) {
      await fillUserData(addingReview);

      reviews.insert(0, addingReview);

      updateRateAndReviews();
      emit(ReviewsGetSuccess());

      emit(ReviewsAddSuccess());
    } else {
      emit(ReviewsAddFailure());
    }
  }

  Future<DataResponse> fillUserData(ReviewModel review) async {
    try {
      final doc = await Collections.users.doc(review.userId).get();

      UserModel user = doc.data()!;

      review.username = user.username;
      review.userImgUrl = user.imgUrl;

      return DataResponse.success;
    } catch (_) {
      return DataResponse.failure;
    }
  }

  void updateRateAndReviews() async {
    double newRate = SortedReviewsList(reviews).calcRate();
    int reviewsCount = reviews.length;

    try {
      await FirebaseFirestore.instance
          .collection("products")
          .doc(productId)
          .update({'rate': newRate, 'reviewsCount': reviewsCount});
    } on Exception catch (_) {}
    updateProductInUI(rate: newRate, reviewsCount: reviewsCount);
  }

  void updateProductInUI({required double rate, required int reviewsCount}) {
    ProductModel? product;

    product = productsCubit.featuredProducts
        .firstWhereOrNull((element) => element.id == productId);
    if (product != null) {
      product.rate = rate;
      product.reviewsCount = reviewsCount;
    }

    product = productsCubit.featuredProductsAtHome
        .firstWhereOrNull((element) => element.id == productId);
    if (product != null) {
      product.rate = rate;
      product.reviewsCount = reviewsCount;
    }
    product = productsCubit.productsOfCategory
        .firstWhereOrNull((element) => element.id == productId);
    if (product != null) {
      product.rate = rate;
      product.reviewsCount = reviewsCount;
    }

    productsCubit.emit(ChangingProductState(productId));
  }

  Future<DataResponse> getReviews() async {
    emit(ReviewsGetLoading());

    final response = await reviewsServices.getReviews(productId);

    if (response.state == DataResponse.success) {
      reviews = response.data;
      emit(ReviewsGetSuccess());
    } else {
      emit(ReviewsGetFailure());
    }

    return response.state;
  }

  @override
  void emit(ReviewsState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
