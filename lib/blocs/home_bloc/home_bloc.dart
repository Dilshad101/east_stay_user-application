import 'dart:async';
import 'package:east_stay/blocs/favorite_bloc/favorite_bloc.dart';
import 'package:east_stay/models/room_model.dart';
import 'package:east_stay/repositories/room_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.favBloc) : super(HomeInitial()) {
    on<HomeGetAllHotelsEvent>(homeGetAllHotelsEvent);
  }

  List<Hotel> hotelList = [];
  FavoriteBloc favBloc;
  FutureOr<void> homeGetAllHotelsEvent(
      HomeGetAllHotelsEvent event, Emitter<HomeState> emit) async {
    List<Hotel>? roomList;
    emit(HomeLoadingState());
    final either = await RoomRepo().getAllRooms();
    // final eitherReview = await RoomRepo().getRoomReview('  ');
    either.fold(
      (error) {
        emit(HomeLoadedFailedState(message: error.message));
      },
      (response) {
        if (response['status'] == 'success') {
          final List rawData = response['roomData'];
          roomList = rawData.map((e) => Hotel.fromJson(e)).toList();
        } else {
          emit(HomeLoadedFailedState(message: 'Something went wrong'));
        }
      },
    );
    if (roomList != null) {
      final either = await RoomRepo().getTopRatedRooms();
      either.fold((error) {
        emit(HomeLoadedFailedState(message: error.message));
      }, (response) {
        final rawRatedRooms = response as List;
        final topRatedRooms =
            rawRatedRooms.map((e) => Hotel.fromJson(e)).toList();
        final classicRoomList = roomList!
            .where((room) => room.category.toLowerCase() == 'classic')
            .toList();
        final eliteRoomList = roomList!
            .where((room) => room.category.toLowerCase() == 'elite')
            .toList();
        final deluxeRoomList = roomList!
            .where((room) => room.category.toLowerCase() == 'deluxe')
            .toList();
        final luxuryRoomList = roomList!
            .where((room) => room.category.toLowerCase() == 'luxury')
            .toList();
        hotelList = roomList!;

        emit(
          HomeLoadedSuccessState(
            classicRoomList: classicRoomList,
            eliteRoomList: eliteRoomList,
            deluxeRoomList: deluxeRoomList,
            luxuryRoomList: luxuryRoomList,
            topRatedRoomList: topRatedRooms,
            totalRoomList: roomList!,
          ),
        );
        favBloc.add(FetchFavoriteRoomsEvent(hotelList: hotelList));
      });
    }

    // emit(HomeLoadedSuccessState());
  }
}
