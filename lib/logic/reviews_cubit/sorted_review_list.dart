import 'package:grocery_app/data/models/review_model.dart';

class SortedReviewsList {
  List<ReviewModel> reviews = [];

  SortedReviewsList(List<ReviewModel> reviews) {
    for (var rev in reviews) {
      add(rev);
    }
  }

  void add(ReviewModel review) {
    if (reviews.isEmpty) {
      reviews.add(review);
    } else if (reviews.last.userId.compareTo(review.userId) <= 0) {
      reviews.add(review);
    } else {
      for (int i = 0; i < reviews.length; i++) {
        if (review.userId.compareTo(reviews[i].userId) < 0) {
          reviews.insert(i, review);
          break;
        }
      }
    }
  }

  double calcRate() {
    double sum = 0;
    double len = 0;

    double subSum = reviews[0].rate;
    double subLen = 1;

    for (int i = 1; i < reviews.length; i++) {
      if (reviews[i].userId == reviews[i - 1].userId) {
        subSum += reviews[i].rate;
        subLen++;
      } else {
        sum += (subSum / subLen);
        subSum = reviews[i].rate;
        subLen = 1;
        len++;
      }
    }

    if (subLen > 0) {
      sum += (subSum / subLen);
      len++;
    }

    return roundRate(sum / len);
  }

  double roundRate(double rate) {
    double frac = rate - rate.floor();

    if (frac > 0.25 && frac < 0.75) {
      return rate - frac + 0.5;
    } else {
      return rate.roundToDouble();
    }
  }
}
