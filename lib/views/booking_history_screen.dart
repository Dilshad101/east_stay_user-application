import 'package:east_stay/resources/components/booking_details.tile.dart';
import 'package:east_stay/resources/components/subtitle.dart';
import 'package:flutter/material.dart';

class ScreenBookingHistory extends StatelessWidget {
  const ScreenBookingHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Bookings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 20),
          const SubTitle(
            'Upcoming Bookings',
            padding: 0,
            fontSize: 17,
          ),
          const SizedBox(height: 10),
          BookingDetailsTile(onCancelRoom: () {}),
          const SizedBox(height: 20),
          const SubTitle(
            'Checked out Rooms',
            padding: 0,
            fontSize: 17,
          ),
          const SizedBox(height: 10),
          const BookingDetailsTile(),
        ],
      ),
    );
  }
}
