import 'package:east_stay/resources/constants/colors.dart';
import 'package:east_stay/resources/constants/text_style.dart';
import 'package:east_stay/resources/components/room_location.dart';
import 'package:east_stay/resources/components/room_price.dart';
import 'package:flutter/material.dart';

class RoomTile extends StatelessWidget {
  const RoomTile({
    super.key,  this.isFavorite=false,
  });
  final bool isFavorite;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(6)),
                    image: const DecorationImage(
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1618773928121-c32242e63f39?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80'),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.deepPurple[100]),
                child: Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.black.withOpacity(.5),
                    child: IconButton(
                      onPressed: () {},
                      icon:  Icon(
                       isFavorite? Icons.favorite:Icons.favorite_border,
                        size: 20,
                        color:isFavorite? AppColor.primaryColor:Colors.white,
                      ),
                    ),
                  ),
                ),
              )),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hotel Paragon',
                  style: AppText.mediumdark,
                  overflow: TextOverflow.ellipsis,
                ),
                const Location(
                  state: 'Kerala',
                  city: 'Kannur',
                  color: AppColor.textPrimary,
                  size: 12,
                ),
                const Price(
                  price: '1000',
                  color: AppColor.textPrimary,
                  size: 12,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
