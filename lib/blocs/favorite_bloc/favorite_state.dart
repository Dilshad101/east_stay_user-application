part of 'favorite_bloc.dart';

abstract class FavoriteState {}

abstract class FavoriteActionState extends FavoriteState {}

final class WishListLoadingState extends FavoriteState {}

final class WishListFetchedState extends FavoriteState {
  final List<Hotel> wishListedRooms;

  WishListFetchedState({required this.wishListedRooms});
}

final class WishListFetchedErrorState extends FavoriteState {
 final String message;

  WishListFetchedErrorState({required this.message});
}

final class WishListFailedState extends FavoriteActionState {
  final String message;

  WishListFailedState({required this.message});
}
