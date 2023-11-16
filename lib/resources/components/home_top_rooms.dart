import 'package:card_swiper/card_swiper.dart';
import 'package:east_stay/blocs/favorite_bloc/favorite_bloc.dart';
import 'package:east_stay/blocs/home_bloc/home_bloc.dart';
import 'package:east_stay/models/room_model.dart';
import 'package:east_stay/resources/constants/colors.dart';
import 'package:east_stay/resources/constants/text_style.dart';
import 'package:east_stay/resources/loaders/shimmer.dart';
import 'package:east_stay/views/room_details_screen.dart';
import 'package:east_stay/resources/components/room_location.dart';
import 'package:east_stay/resources/components/room_price.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTopRooms extends StatelessWidget {
  const HomeTopRooms({super.key});

  @override
  Widget build(BuildContext context) {
    final dwidth = MediaQuery.of(context).size.width;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return shimmerLoader(dwidth);
        } else if (state is HomeLoadedSuccessState) {
          context
              .read<FavoriteBloc>()
              .add(FetchFavoriteRoomsEvent(hotelList: state.totalRoomList));
          return roomView(dwidth, state.topRatedRoomList);
        } else if (state is HomeLoadedFailedState) {
          return errorView(state.message);
        }
        return const SizedBox();
      },
    );
  }

  SizedBox errorView(String message) {
    return SizedBox(
        height: 180,
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              size: 30,
              color: Colors.red,
            ),
            const SizedBox(height: 15),
            Text(message, style: AppText.largeDark.copyWith(color: Colors.grey))
          ],
        ));
  }

  SizedBox roomView(double dwidth, List<Hotel> roomList) {
    return SizedBox(
        width: double.maxFinite,
        height: 180,
        child: Swiper(
          itemCount: roomList.length <= 4 ? roomList.length : 4,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => ScreenRoomDetails(
                        room: roomList[index],
                      )),
            ),
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    image: DecorationImage(
                      image: NetworkImage(roomList[index].img[0]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black45,
                        Colors.black54
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      const Expanded(child: SizedBox()),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              roomList[index].vendor.propertyName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 5),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Location(
                        state: roomList[index].state,
                        city: roomList[index].city,
                      ),
                      const SizedBox(height: 4),
                      Price(price: roomList[index].price),
                    ],
                  ),
                )
              ],
            ),
          ),
          pagination: roomList.length <= 1
              ? null
              : const SwiperPagination(
                  builder: DotSwiperPaginationBuilder(
                      activeColor: AppColor.primaryColor,
                      color: Color(0xFFE0E0E0),
                      activeSize: 11,
                      space: 4),
                ),
        ));
  }

  SizedBox shimmerLoader(double dwidth) {
    return SizedBox(
      width: dwidth,
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: 4,
        itemBuilder: (context, index) => Container(
          padding: const EdgeInsets.all(10),
          width: dwidth * .8,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerLoader(height: 15, width: dwidth * .6),
              ShimmerLoader(height: 10, width: dwidth * .4),
              ShimmerLoader(height: 10, width: dwidth * .4),
            ],
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(width: 10),
      ),
    );
  }
}
