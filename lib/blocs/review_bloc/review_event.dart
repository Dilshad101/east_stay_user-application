part of 'review_bloc.dart';

abstract class ReviewEvent {}

class FetchReviewEvent extends ReviewEvent {
  final String roomId;

  FetchReviewEvent(this.roomId);
}

class FetchUserReviewEvent extends ReviewEvent {
  final String roomId;

  FetchUserReviewEvent({required this.roomId});
}
