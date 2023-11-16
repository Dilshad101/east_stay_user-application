import 'package:east_stay/data/shared_preferences/shared_pref.dart';
import 'package:east_stay/models/room_model.dart';
import 'package:east_stay/repositories/room_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(WishListLoadingState()) {
    on<FetchFavoriteRoomsEvent>(_fetchFavorites);
    on<AddToWishListEvent>(_addToWishList);
    on<RemoveFromWishListEvent>(_removeFromWishList);
  }
  final List<Hotel> favoriteRooms = [];
  _fetchFavorites(
      FetchFavoriteRoomsEvent event, Emitter<FavoriteState> emit) async {
    favoriteRooms.clear();
    final userId = SharedPref.instance.getUserId();
    final either = await RoomRepo().getWishListedRooms(userId!);
    either.fold((error) {
      emit(WishListFetchedErrorState(message: error.message));
    }, (response) {
      final rawList = response as List;
      for (var room in rawList) {
        final roomId = room['roomId']['_id'];
        final favRoom = event.hotelList.where((e) => e.id == roomId).first;
        favoriteRooms.add(favRoom);
      }

      emit(WishListFetchedState(wishListedRooms: favoriteRooms));
    });
  }

  _addToWishList(AddToWishListEvent event, Emitter<FavoriteState> emit) async {
    final body = {'vendorId': event.room.vendor.id, 'roomId': event.room.id};
    favoriteRooms.add(event.room);
    emit(WishListFetchedState(wishListedRooms: favoriteRooms));
    final either = await RoomRepo().addToWishlist(body);
    either.fold((error) {
      emit(WishListFailedState(message: error.message));
      favoriteRooms.removeWhere((e) => e.id == event.room.id);
      emit(WishListFetchedState(wishListedRooms: favoriteRooms));
    }, (response) {
      if (response['status'] == 'success') {
        emit(WishListFetchedState(wishListedRooms: favoriteRooms));
      }
    });
  }

  _removeFromWishList(
      RemoveFromWishListEvent event, Emitter<FavoriteState> emit) async {
    final either = await RoomRepo().removeFromWishlist(event.room.id);
    favoriteRooms.removeWhere((element) => element.id == event.room.id);
    either.fold((error) {
      emit(WishListFailedState(message: error.message));
      favoriteRooms.add(event.room);
      emit(WishListFetchedState(wishListedRooms: favoriteRooms));
      favoriteRooms.add(event.room);
    }, (response) {
      if (response['status'] == 'success') {
        emit(WishListFetchedState(wishListedRooms: favoriteRooms));
      }
    });
  }
}
