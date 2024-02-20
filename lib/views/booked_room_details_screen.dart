import 'package:east_stay/blocs/booked_room_bloc/booked_room_bloc.dart';
import 'package:east_stay/models/booked_room_model.dart';
import 'package:east_stay/resources/components/box_tile.dart';
import 'package:east_stay/resources/components/reviews.dart';
import 'package:east_stay/resources/constants/colors.dart';
import 'package:east_stay/resources/constants/text_style.dart';
import 'package:east_stay/utils/services.dart';
import 'package:east_stay/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ScreenBookedRoomDetails extends StatelessWidget {
  const ScreenBookedRoomDetails(
      {super.key, required this.bookedRoom, this.showCancel = false});
  final BookedRoom bookedRoom;
  final bool showCancel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('your Bookings')),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.grey[200],
              image: DecorationImage(
                image: NetworkImage(bookedRoom.room.img[0]),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: AppColor.color(bookedRoom.room.category),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Text('Classic',
                    style: AppText.smallLight.copyWith(color: Colors.white)),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(bookedRoom.vendor.propertyName, style: AppText.xLarge),
          Text(
            '${bookedRoom.room.city} ${bookedRoom.room.state}',
            style: AppText.smallDark
                .copyWith(fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 70,
            width: double.maxFinite,
            child: Row(
              children: [
                BoxTile(
                    type: BoxType.multiLine,
                    title: 'Check In',
                    value: formatDate(bookedRoom.checkIn)),
                const SizedBox(width: 8),
                BoxTile(
                    type: BoxType.multiLine,
                    title: 'Check Out',
                    value: formatDate(bookedRoom.checkOut)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 70,
            width: double.maxFinite,
            child: Row(
              children: [
                BoxTile(
                    type: BoxType.multiLine,
                    title: 'Total Days',
                    value: bookedRoom.days.toString()),
                const SizedBox(width: 8),
                BoxTile(
                    type: BoxType.multiLine,
                    title: 'Rent',
                    value: bookedRoom.roomPrice.toString()),
              ],
            ),
          ),
          const SizedBox(height: 15),
          BoxTile(
            type: BoxType.singleLine,
            title: 'Booking ID',
            value: bookedRoom.id,
          ),
          const SizedBox(height: 8),
          BoxTile(
            title: 'Total Price',
            value: '₹ ${bookedRoom.total}',
            type: BoxType.singleLine,
            price: true,
          ),
          const SizedBox(height: 10),
          callButton(),
          const SizedBox(height: 15),
          showCancel
              ? button(context)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Your review", style: AppText.mediumdark),
                    Reviews(
                      room: bookedRoom.room,
                      singleUser: true,
                    ),
                  ],
                ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  GestureDetector callButton() {
    return GestureDetector(
      onTap: () => AppService.launchPhone(bookedRoom.vendor.phone),
      child: Container(
        height: 48,
        alignment: Alignment.center,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.blue[800],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          'Call Hotel Manager',
          style: AppText.mediumLight,
        ),
      ),
    );
  }

  Widget button(BuildContext context) {
    return BlocListener<BookedRoomBloc, BookedRoomState>(
      listenWhen: (previous, current) => current is BookedRoomActionState,
      listener: (context, state) {
        if (state is RoomCancelSuccessState) {
          MessageViewer.showSnackBar(context, 'Room has been canceled');
        } else if (state is RoomCancelFailedState) {
          MessageViewer.showSnackBar(context, state.message);
        }
      },
      child: OutlinedButton(
        style: ButtonStyle(
          side: MaterialStateProperty.all(const BorderSide(color: Colors.red)),
          fixedSize: MaterialStateProperty.all(const Size.fromHeight(52)),
        ),
        onPressed: () => context
            .read<BookedRoomBloc>()
            .add(CancelBookedRoomsEvent(bookId: bookedRoom.id)),
        child: const Text(
          'Cancel',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  String formatDate(DateTime date) {
    final formatter = DateFormat('MMM-dd-yyyy');
    return formatter.format(date);
  }
}
