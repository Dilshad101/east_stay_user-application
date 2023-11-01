import 'package:cached_network_image/cached_network_image.dart';
import 'package:east_stay/models/room_model.dart';
import 'package:east_stay/resources/constants/colors.dart';
import 'package:east_stay/resources/constants/text_style.dart';
import 'package:east_stay/resources/loaders/shimmer.dart';
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
    return Container(
      height: 140,
      padding: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            width: dwidth * .35,
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: hotel.img[0],
                placeholder: (context, url) => const ShimmerLoader(
                    height: double.maxFinite, width: double.maxFinite),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hotel.vendor.propertyName,
                  style: AppText.largeDark,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    const Icon(Icons.star, size: 18, color: AppColor.gold),
                    Text(' 4.3', style: AppText.smallLight)
                  ],
                ),
                // SizedBox(height: 4),
                Text('${hotel.city}  ${hotel.state}',
                    style: AppText.smallLight),
                const SizedBox(height: 4),
                Price(price: hotel.price, color: AppColor.textSecondary),
                const Expanded(child: SizedBox()),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 30,
                    width: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(6),
                        bottomRight: Radius.circular(6),
                      ),
                      color: Colors.blue[800],
                    ),
                    child: Text(hotel.category,
                        style: AppText.smallLight.copyWith(color: Colors.white)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
