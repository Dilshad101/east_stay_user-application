part of 'review_bloc.dart';

abstract class ReviewState {}

final class ReviewInitial extends ReviewState {}

final class ReviewFetchedSuccessState extends ReviewState {
  final List<ReviewModel> reviews;

  ReviewFetchedSuccessState(this.reviews);
}

final class ReviewLoadingState extends ReviewState {}

final class ReviewEmptyState extends ReviewState {}
