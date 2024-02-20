import 'package:cached_network_image/cached_network_image.dart';
import 'package:east_stay/models/room_model.dart';
import 'package:east_stay/resources/constants/colors.dart';
import 'package:east_stay/resources/constants/text_style.dart';
import 'package:east_stay/resources/components/room_location.dart';
import 'package:east_stay/resources/components/room_price.dart';
import 'package:east_stay/resources/loaders/shimmer.dart';
import 'package:east_stay/views/room_details_screen.dart';
import 'package:flutter/material.dart';

class RoomTile extends StatelessWidget {
  const RoomTile({
    super.key,
    this.isFavorite = false,
    required this.room,
  });
  final bool isFavorite;
  final Hotel room;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: room.img[0],
                  placeholder: (context, url) => const ShimmerLoader(
                      height: double.maxFinite, width: double.maxFinite),
                  errorWidget: (context, url, error) {
                    return const Center(child: Icon(Icons.error,color: Colors.grey));
                  },
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    room.vendor.propertyName,
                    style: AppText.mediumdark,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Location(
                    state: room.state,
                    city: room.city,
                    color: AppColor.textPrimary,
                    size: 12,
                  ),
                  Price(
                    price: room.price,
                    color: AppColor.textPrimary,
                    size: 12,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ScreenRoomDetails(room: room)));
      },
    );
  }
}
