import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:east_stay/models/room_model.dart';
import 'package:east_stay/resources/constants/colors.dart';
import 'package:east_stay/resources/constants/text_style.dart';
import 'package:east_stay/resources/loaders/shimmer.dart';
import 'package:east_stay/views/booking_screen.dart';
import 'package:east_stay/resources/components/amenities.dart';
import 'package:east_stay/resources/components/coupons.dart';
import 'package:east_stay/resources/components/reviews.dart';
import 'package:east_stay/resources/components/room_price.dart';
import 'package:east_stay/resources/components/subtitle.dart';
import 'package:flutter/material.dart';

class ScreenRoomDetails extends StatelessWidget {
  const ScreenRoomDetails({super.key, required this.room});
  final Hotel room;
  @override
  Widget build(BuildContext context) {
    final dheight = MediaQuery.sizeOf(context).height;
    final safeArea = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            children: [
              // image Slider
              hotelImages(dheight),
              const SizedBox(height: 20),
              Padding(
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
                    catagory(room.category)
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  room.description,
                  style: AppText.smallLight,
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 20),
              const SubTitle('Amenities'),
              const SizedBox(height: 10),
              Amenities(amenities: room.amenities),
              const SizedBox(height: 20),
              // const SubTitle('Coupons'),
              // const SizedBox(height: 10),
              const Coupons(),
              const SizedBox(height: 20),
              const SubTitle('Location'),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: dheight * .25,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppColor.grey,
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  SubTitle('Reviews'),
                  SizedBox(width: 5),
                  Icon(
                    Icons.star,
                    color: AppColor.gold,
                    size: 20,
                  ),
                  SizedBox(width: 5),
                  Text(
                    '(4.2)',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColor.textPrimary,
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Text(
                    'View more',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
              const SizedBox(height: 10),
              const Reviews(),
              const SizedBox(height: 40)
            ],
          ),
          Positioned(
            top: safeArea + 10,
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
          )
        ],
      ),
      bottomNavigationBar: Container(
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
                child:  Price(
                  price:room.price,
                  size: 18,
                  textSize: 14,
                  color: AppColor.secondaryColor,
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => const ScreenBooking(),
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
      ),
    );
  }

  Container catagory(String catagory) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppColor.gold,
      ),
      child:  Text(
        catagory,
        style:const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 1,
        ),
      ),
    );
  }

  SizedBox hotelImages(double dheight) {
    return SizedBox(
      height: dheight * .38,
      child: Swiper(
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
    );
  }
}
