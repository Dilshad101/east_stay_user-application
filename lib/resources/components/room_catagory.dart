import 'package:east_stay/blocs/home_bloc/home_bloc.dart';
import 'package:east_stay/models/room_model.dart';
import 'package:east_stay/resources/components/room_tile.dart';
import 'package:east_stay/resources/constants/text_style.dart';
import 'package:east_stay/resources/loaders/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomCatagory extends StatelessWidget {
  const RoomCatagory({
    super.key,
    required this.catagory,
  });
  final String catagory;
  @override
  Widget build(BuildContext context) {
    final dwidth = MediaQuery.sizeOf(context).width;
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is HomeLoadingState) {
        return shimmerLoader(dwidth);
      } else if (state is HomeLoadedSuccessState) {
        final roomCatagory = {
          'Classic': state.classicRoomList,
          'Elite': state.eliteRoomList,
          'Deluxe': state.deluxeRoomList,
          'Luxury': state.luxuryRoomList
        };
        return roomView(roomCatagory[catagory]!);
      }
      return const SizedBox();
    });
  }

  GridView shimmerLoader(double dwidth) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1 / 1.2,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6), color: Colors.grey[200]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ShimmerLoader(height: 125, width: double.maxFinite),
            const SizedBox(height: 10),
            ShimmerLoader(height: 12, width: dwidth * .33),
            ShimmerLoader(height: 10, width: dwidth * .3),
            ShimmerLoader(height: 10, width: dwidth * .3),
          ],
        ),
      ),
    );
  }

  Widget roomView(List<Hotel> roomList) {
    return roomList.isEmpty
        ?  Center(
            child: Text('No room available in this catagory',style: AppText.mediumdark,),
          )
        : GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1 / 1.2),
            itemCount: roomList.length,
            itemBuilder: (context, index) => RoomTile(
                  room: roomList[index],
                ));
  }
}
