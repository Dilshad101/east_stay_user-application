import 'package:east_stay/models/review_model.dart';
import 'package:east_stay/repositories/room_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  ReviewBloc() : super(ReviewInitial()) {
    on<FetchReviewEvent>(_fetchReviews);
  }

  _fetchReviews(FetchReviewEvent event, Emitter<ReviewState> emit) async {
    emit(ReviewLoadingState());
    final either = await RoomRepo().getRoomReview(event.roomId);
    either.fold((left) => print(left), (response) {
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
}
