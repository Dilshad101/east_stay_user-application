import 'package:cached_network_image/cached_network_image.dart';
import 'package:east_stay/models/room_model.dart';
import 'package:east_stay/resources/constants/colors.dart';
import 'package:east_stay/resources/constants/text_style.dart';
import 'package:east_stay/resources/loaders/shimmer.dart';
import 'package:east_stay/views/room_details_screen.dart';
import 'package:flutter/material.dart';

import 'room_price.dart';

class SearchTile extends StatelessWidget {
  const SearchTile({
    super.key,
    required this.hotel,
  });
  final Hotel hotel;
  @override
  Widget build(BuildContext context) {
    final dwidth = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ScreenRoomDetails(room: hotel)),
      ),
      child: Container(
        height: 100,
        // padding: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              width: dwidth * .35,
              height: double.maxFinite,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: CachedNetworkImage(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      fit: BoxFit.cover,
                      imageUrl: hotel.img[0],
                      placeholder: (context, url) => const ShimmerLoader(
                          height: double.maxFinite, width: double.maxFinite),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  Container(
                    height: 26,
                    width: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(6),
                        bottomRight: Radius.circular(6),
                      ),
                      color: AppColor.color(hotel.category).withOpacity(.8),
                    ),
                    child: Text(hotel.category,
                        style: AppText.xSmall.copyWith(color: Colors.white)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    hotel.vendor.propertyName,
                    style: AppText.largeDark,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text('${hotel.city}  ${hotel.state}',
                      style: AppText.smallLight),
                  const SizedBox(height: 4),
                  Price(price: hotel.price, color: AppColor.textSecondary),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
