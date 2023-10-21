
import 'package:east_stay/utils/constents/colors.dart';
import 'package:east_stay/utils/constents/text_style.dart';
import 'package:flutter/material.dart';

import 'room_location.dart';
import 'room_price.dart';

class HomeBrowseRooms extends StatelessWidget {
  const HomeBrowseRooms({
    super.key,
   
  });

  @override
  Widget build(BuildContext context) {
    final dwidth = MediaQuery.sizeOf(context).width;
    return SizedBox(
      height: 280,
      width: dwidth,
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        itemBuilder: (context, index) => Container(
          width: dwidth * .6,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.white),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1618773928121-c32242e63f39?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(.6),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(10),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Taj Resort',
                            style:AppText.xLarge,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Icon(
                          Icons.star,
                          size: 18,
                          color: AppColor.gold,
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          '(4.2)',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: AppColor.textPrimary),
                        )
                      ],
                    ),
                    const Location(
                      state: 'Kerala',
                      city: 'Kannur',
                      color: AppColor.textPrimary,
                    ),
                    const SizedBox(height: 5),
                    const Price(price: '1200',color: AppColor.textPrimary,)
                  ],
                ),
              )),
            ],
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(width: 15),
      ),
    );
  }
}
