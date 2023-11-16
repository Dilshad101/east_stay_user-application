part of 'review_bloc.dart';

abstract class ReviewEvent {}

class FetchReviewEvent extends ReviewEvent {
  final String roomId;

  FetchReviewEvent(this.roomId);
}
