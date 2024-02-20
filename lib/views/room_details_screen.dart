import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:east_stay/blocs/favorite_bloc/favorite_bloc.dart';
import 'package:east_stay/blocs/review_bloc/review_bloc.dart';
import 'package:east_stay/models/room_model.dart';
import 'package:east_stay/resources/components/map_box.dart';
import 'package:east_stay/resources/constants/colors.dart';
import 'package:east_stay/resources/constants/text_style.dart';
import 'package:east_stay/resources/loaders/shimmer.dart';
import 'package:east_stay/utils/snack_bar.dart';
import 'package:east_stay/views/booking_screen.dart';
import 'package:east_stay/resources/components/amenities.dart';
import 'package:east_stay/resources/components/coupon_view.dart';
import 'package:east_stay/resources/components/reviews.dart';
import 'package:east_stay/resources/components/room_price.dart';
import 'package:east_stay/resources/components/subtitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenRoomDetails extends StatelessWidget {
  const ScreenRoomDetails({super.key, required this.room});
  final Hotel room;
  @override
  Widget build(BuildContext context) {
    final dheight = MediaQuery.sizeOf(context).height;
    context.read<ReviewBloc>().add(FetchReviewEvent(room.id));
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            children: [
              hotelImages(dheight, context),
              const SizedBox(height: 20),
              hotelName(),
              const SizedBox(height: 10),
              description(),
              const SizedBox(height: 20),
              const SubTitle('Amenities'),
              const SizedBox(height: 10),
              Amenities(amenities: room.amenities),
              const SizedBox(height: 20),
              Coupons(vendor: room.vendor),
              const SubTitle('Location'),
              const SizedBox(height: 10),
              map(dheight, room),
              const SizedBox(height: 20),
              Reviews(room: room),
              const SizedBox(height: 20)
            ],
          ),
          // backButton(context)
        ],
      ),
      bottomNavigationBar: bottomButton(context),
    );
  }

  Container bottomButton(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.black26, width: .5),
        ),
      ),
      height: 65,
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Price(
                price: room.price,
                size: 18,
                textSize: 14,
                color: AppColor.secondaryColor,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => ScreenBooking(hotel: room)),
                );
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(15, 8, 10, 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: AppColor.primaryColor,
                ),
                alignment: Alignment.center,
                child: Text(
                  'Book now',
                  style: AppText.largeLight,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding description() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        room.description,
        style: AppText.smallLight,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Padding hotelName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  room.vendor.propertyName,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColor.secondaryColor,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColor.color(room.category),
                ),
                child: Text(
                  room.category,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
              )
            ],
          ),
          Text(
            '${room.state} ${room.city}',
            style: AppText.mediumdark,
          )
        ],
      ),
    );
  }

  Widget hotelImages(double dheight, BuildContext context) {
    return SizedBox(
      height: dheight * .38,
      child: Stack(
        children: [
          Swiper(
            itemCount: room.img.length,
            itemBuilder: (context, index) => CachedNetworkImage(
              imageUrl: room.img[index],
              placeholder: (context, url) => const ShimmerLoader(
                height: double.maxFinite,
                width: double.maxFinite,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
            pagination: const SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                  activeColor: AppColor.primaryColor,
                  color: Color(0xFFE0E0E0),
                  activeSize: 11,
                  space: 4),
            ),
          ),
          buttons(context)
        ],
      ),
    );
  }

  Widget buttons(BuildContext context) {
    return Positioned(
      left: 20,
      right: 20,
      top: MediaQuery.of(context).padding.top + 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.white.withOpacity(.4),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
          BlocConsumer<FavoriteBloc, FavoriteState>(
            buildWhen: (previous, current) => current is! FavoriteActionState,
            listenWhen: (previous, current) => current is FavoriteActionState,
            listener: (context, state) {
              if (state is WishListFailedState) {
                MessageViewer.showSnackBar(context, state.message);
              }
            },
            builder: (context, state) {
              if (state is WishListFetchedState) {
                final isFavorite = state.wishListedRooms
                    .where((favRoom) => favRoom.id == room.id)
                    .firstOrNull;
                return CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.white.withOpacity(.4),
                  child: IconButton(
                    onPressed: () {
                      context.read<FavoriteBloc>().add(
                            isFavorite == null
                                ? AddToWishListEvent(room: room)
                                : RemoveFromWishListEvent(room: room),
                          );
                    },
                    icon: Icon(
                      isFavorite != null
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: const Color(0xffFF0000),
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          )
        ],
      ),
    );
  }
}
