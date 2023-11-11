import 'package:grocery_app/constants/enums.dart';
import 'package:grocery_app/data/models/review_model.dart';
import 'package:grocery_app/data/models/user_model.dart';
import 'package:grocery_app/helper/collections.dart';

class ReviewsServices {
  Future<DataResponse> addReview(ReviewModel review) async {
    try {
      await Collections.reviews(productId: review.productId).add(review);
      return DataResponse.success;
    } catch (_) {
      return DataResponse.failure;
    }
  }

  Future<({List<ReviewModel> data, DataResponse state})> getReviews(
      String productId) async {
    List<ReviewModel> reviews = [];
    try {
      final snapshotReviews = await Collections.reviews(productId: productId)
          .orderBy('date', descending: true)
          .get();

      reviews = snapshotReviews.docs
          .map(
            (e) => e.data(),
          )
          .toList();

      await fillUserData(reviews);

      return (data: reviews, state: DataResponse.success);
    } catch (_) {
      return (data: reviews, state: DataResponse.failure);
    }
  }

  Future<void> fillUserData(List<ReviewModel> reviews) async {
    final snapshotUsers = await Collections.users.get();

    for (var review in reviews) {
      UserModel user = snapshotUsers.docs
          .firstWhere((element) => element.id == review.userId)
          .data();
      review.username = user.username;
      review.userImgUrl = user.imgUrl;
    }
  }
}
