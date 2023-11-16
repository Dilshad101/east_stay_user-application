part of 'favorite_bloc.dart';

abstract class FavoriteEvent {}

class AddToWishListEvent extends FavoriteEvent {
  final Hotel room;

  AddToWishListEvent({required this.room});
}

class FetchFavoriteRoomsEvent extends FavoriteEvent {
  final List<Hotel> hotelList;

  FetchFavoriteRoomsEvent({required this.hotelList});
}

class RemoveFromWishListEvent extends FavoriteEvent {
  final Hotel room;

  RemoveFromWishListEvent({required this.room});
}
