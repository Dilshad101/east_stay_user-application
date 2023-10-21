import 'package:east_stay/views/room_details_screen.dart';
import 'package:east_stay/resources/components/room_location.dart';
import 'package:east_stay/resources/components/room_price.dart';
import 'package:flutter/material.dart';

import 'rating_bar.dart';

class HomeTopRooms extends StatelessWidget {
  const HomeTopRooms({super.key});

  @override
  Widget build(BuildContext context) {
    final dwidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: double.maxFinite,
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ScreenRoomDetails()),
          ),
          child: Stack(
            children: [
              Container(
                width: dwidth * .8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: const DecorationImage(
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1618773928121-c32242e63f39?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: dwidth * .8,
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
                    //fav button
                    Align(
                      alignment: Alignment.topRight,
                      child: CircleAvatar(
                        backgroundColor: Colors.black.withOpacity(.6),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite_border,
                          ),
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            'Hotel Paragon',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 5),
                        Ratings()
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Location(
                      state: 'Kerala',
                      city: 'Calicut',
                    ),
                    const SizedBox(height: 4),
                    const Price(
                      price: '1000',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(width: 10),
      ),
    );
  }
}
