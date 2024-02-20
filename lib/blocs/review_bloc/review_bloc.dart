import 'package:east_stay/data/shared_preferences/shared_pref.dart';
import 'package:east_stay/models/review_model.dart';
import 'package:east_stay/repositories/room_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  ReviewBloc() : super(ReviewInitial()) {
    on<FetchReviewEvent>(_fetchReviews);
    on<FetchUserReviewEvent>(_fetchuserReview);
  }

  _fetchReviews(FetchReviewEvent event, Emitter<ReviewState> emit) async {
    emit(ReviewLoadingState());
    final either = await RoomRepo().getRoomReview(event.roomId);
    either.fold((left) {
      emit(ReviewEmptyState());
    }, (response) {
      final rawReviews = response['review'] as List;
      if (rawReviews.isNotEmpty) {
        double sum = 0;
        List<ReviewModel> reviews = rawReviews.map((e) {
          final review = ReviewModel.fromJson(e);
          sum += double.parse(review.stars);
          return review;
        }).toList();
        final averageRating = sum / reviews.length;
        reviews = reviews.map((e) => e..avgRating = averageRating).toList();
        emit(ReviewFetchedSuccessState(reviews));
      } else {
        emit(ReviewEmptyState());
      }
    });
  }

  _fetchuserReview(
      FetchUserReviewEvent event, Emitter<ReviewState> emit) async {
    emit(ReviewLoadingState());
    final either = await RoomRepo().getRoomReview(event.roomId);
    final userId = SharedPref.instance.getUserId()!;
    either.fold((left) {
      emit(ReviewEmptyState());
    }, (response) {
      final rawReviews = response['review'] as List;
      if (rawReviews.isNotEmpty) {
        double sum = 0;
        List<ReviewModel> reviews = rawReviews.map((e) {
          final review = ReviewModel.fromJson(e);
          sum += double.parse(review.stars);
          return review;
        }).toList();
        final averageRating = sum / reviews.length;
        reviews = reviews.map((e) => e..avgRating = averageRating).toList();
        reviews = reviews.where((e) => e.userId == userId).toList();
        emit(ReviewFetchedSuccessState(reviews));
      } else {
        emit(ReviewEmptyState());
      }
    });
  }
}
