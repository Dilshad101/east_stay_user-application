import 'package:east_stay/blocs/favorite_bloc/favorite_bloc.dart';
import 'package:east_stay/resources/components/room_tile.dart';
import 'package:east_stay/resources/constants/text_style.dart';
import 'package:east_stay/resources/loaders/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenFavorite extends StatelessWidget {
  const ScreenFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite')),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        buildWhen: (previous, current) => current is! FavoriteActionState,
        builder: (context, state) {
          if (state is WishListFetchedState) {
            return wishListView(state);
          } else if (state is WishListLoadingState) {
            return loadingView();
          } else if (state is WishListFetchedErrorState) {
            return errorView(state);
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget wishListView(WishListFetchedState state) {
    return state.wishListedRooms.isEmpty
        ? Center(
            child: Text('You have no favorite Rooms',
                style: AppText.mediumLight.copyWith(color: Colors.grey)))
        : GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) => RoomTile(
              isFavorite: true,
              room: state.wishListedRooms[index],
            ),
            itemCount: state.wishListedRooms.length,
          );
  }

  GridView loadingView() {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) => const ShimmerLoader(
          height: double.maxFinite, width: double.maxFinite),
      itemCount: 4,
    );
  }

  Center errorView(WishListFetchedErrorState state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.warning_amber_rounded, color: Colors.red),
          const SizedBox(height: 15),
          Text(
            state.message,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
