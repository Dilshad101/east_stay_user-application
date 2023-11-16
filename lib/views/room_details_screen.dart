import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:east_stay/blocs/favorite_bloc/favorite_bloc.dart';
import 'package:east_stay/blocs/review_bloc/review_bloc.dart';
import 'package:east_stay/models/room_model.dart';
import 'package:east_stay/resources/constants/colors.dart';
import 'package:east_stay/resources/constants/text_style.dart';
import 'package:east_stay/resources/loaders/shimmer.dart';
import 'package:east_stay/utils/map_helper.dart';
import 'package:east_stay/utils/snack_bar.dart';
import 'package:east_stay/views/booking_screen.dart';
import 'package:east_stay/resources/components/amenities.dart';
import 'package:east_stay/resources/components/coupon_view.dart';
import 'package:east_stay/resources/components/reviews.dart';
import 'package:east_stay/resources/components/room_price.dart';
import 'package:east_stay/resources/components/subtitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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
              map(dheight),
              const SizedBox(height: 20),
              Reviews(room: room),
              const SizedBox(height: 20)
            ],
          ),
          backButton(context)
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

  Positioned backButton(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: 20,
      child: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.white,
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
    );
  }

  Container map(double dheight) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: dheight * .25,
      width: double.maxFinite,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
      child: AbsorbPointer(
        absorbing: true,
        child: FlutterMap(
          options: MapOptions(
            initialCenter: getLatLng(room.latitude.toString(), room.longitude),
            initialZoom: 14,
          ),
          children: [
            TileLayer(
              urlTemplate: MapHelper.urlTemplate,
              additionalOptions: const {
                "accessToken": MapHelper.accessToken,
                "id": MapHelper.mapId
              },
            ),
            MarkerLayer(alignment: Alignment.center, markers: [
              Marker(
                height: 100,
                width: 100,
                point: getLatLng(room.latitude.toString(), room.longitude),
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 35,
                ),
              )
            ])
          ],
        ),
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
      child: Row(
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: AppColor.gold,
            ),
            child: Text(
              room.category,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
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
          favButton(context)
        ],
      ),
    );
  }

  Widget favButton(BuildContext context) {
    return Positioned(
        top: MediaQuery.of(context).padding.top + 10,
        right: 20,
        child: BlocConsumer<FavoriteBloc, FavoriteState>(
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
                backgroundColor: Colors.white,
                child: IconButton(
                  onPressed: () {
                    context.read<FavoriteBloc>().add(
                          isFavorite == null
                              ? AddToWishListEvent(room: room)
                              : RemoveFromWishListEvent(room: room),
                        );
                  },
                  icon: Icon(
                    isFavorite != null ? Icons.favorite : Icons.favorite_border,
                    color: AppColor.primaryColor,
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ));
  }

  LatLng getLatLng(String lat, String lng) {
    final latitude = double.parse(lat);
    final longitude = double.parse(lng);
    return LatLng(latitude, longitude);
  }
}
