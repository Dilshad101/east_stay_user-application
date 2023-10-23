import 'dart:async';

import 'package:east_stay/models/room_model.dart';
import 'package:east_stay/repositories/room_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeGetAllHotelsEvent>(homeGetAllHotelsEvent);
  }

  FutureOr<void> homeGetAllHotelsEvent(
      HomeGetAllHotelsEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    final either = await RoomRepo().getAllRooms();
    either.fold(
      (error) {},
      (response) {
        if (response['status'] == 'success') {
          final List rawData = response['roomData'];
          final List<Hotel> roomList =
              rawData.map((e) => Hotel.fromJson(e)).toList();
          final classicRoomList = roomList
              .where((room) => room.category.toLowerCase() == 'classic')
              .toList();
          final eliteRoomList = roomList
              .where((room) => room.category.toLowerCase() == 'elite')
              .toList();
          final deluxeRoomList = roomList
              .where((room) => room.category.toLowerCase() == 'deluxe')
              .toList();
          final luxuryRoomList = roomList
              .where((room) => room.category.toLowerCase() == 'luxury')
              .toList();
          emit(
            HomeLoadedSuccessState(
              classicRoomList: classicRoomList,
              eliteRoomList: eliteRoomList,
              deluxeRoomList: deluxeRoomList,
              luxuryRoomList: luxuryRoomList,
              topRatedRoomList: roomList,
            ),
          );
        } else {
          print('failed to get roomList');
          emit(HomeLoadedFailedState());
        }
      },
    );

    // emit(HomeLoadedSuccessState());
  }
}
