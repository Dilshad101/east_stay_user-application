import 'package:flutter_bloc/flutter_bloc.dart';

part 'rating_event.dart';
part 'rating_state.dart';

class RatingBloc extends Bloc<RatingEvent, RatingState> {
  RatingBloc() : super(RatingInitial()) {
    on<RatingEvent>((event, emit) {});
  }
}
