part of 'home_bloc.dart';

abstract class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeLoadedSuccessState extends HomeState {
  final List<Hotel> classicRoomList;
  final List<Hotel> eliteRoomList;
  final List<Hotel> deluxeRoomList;
  final List<Hotel> luxuryRoomList;
  final List<Hotel> topRatedRoomList;
  final List<Hotel> totalRoomList;

  HomeLoadedSuccessState({
    required this.topRatedRoomList,
    required this.classicRoomList,
    required this.deluxeRoomList,
    required this.eliteRoomList,
    required this.luxuryRoomList,
    required this.totalRoomList,
  });
}

final class HomeLoadedFailedState extends HomeState {
  final String message;

  HomeLoadedFailedState({required this.message});
}

final class HomeErrorState extends HomeState {}
