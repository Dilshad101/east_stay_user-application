import 'package:east_stay/blocs/booked_room_bloc/booked_room_bloc.dart';
import 'package:east_stay/models/booked_room_model.dart';
import 'package:east_stay/resources/constants/colors.dart';
import 'package:east_stay/resources/constants/text_style.dart';
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
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.grey,
                image: DecorationImage(
                  image: NetworkImage(bookedRoom.room.img[0]),
                  fit: BoxFit.cover,
                )),
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
                dateField('Check In', formatDate(bookedRoom.checkIn), true),
                const SizedBox(width: 8),
                dateField('Check Out', formatDate(bookedRoom.checkOut)),
              ],
            ),
          ),
          const SizedBox(height: 15),
          keyValue('Room Type', bookedRoom.type, true),
          const SizedBox(height: 15),
          keyValue('Total Price', '₹ ${bookedRoom.total}', false),
          const SizedBox(height: 15),
          keyValue('Booking ID', bookedRoom.id, false),
          const SizedBox(height: 30),
          showCancel ? button(context) : const SizedBox(),
          const SizedBox(height: 15),
        ],
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
            side:
                MaterialStateProperty.all(const BorderSide(color: Colors.red)),
            fixedSize: MaterialStateProperty.all(const Size.fromHeight(52)),
          ),
          onPressed: () => context
              .read<BookedRoomBloc>()
              .add(CancelBookedRoomsEvent(bookId: bookedRoom.id)),
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.red),
          ),
        ));
  }

  Row keyValue(String key, String value, bool inBox, {Color? color}) {
    return Row(
      children: [
        Text(key, style: AppText.mediumdark),
        const Spacer(),
        inBox
            ? Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.grey[700]),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Text(value,
                    style: AppText.smallLight.copyWith(color: Colors.white)),
              )
            : Text(value,
                style: AppText.smallLight.copyWith(
                    color: color ?? AppColor.secondaryColor,
                    fontFamily: 'Ubuntu')),
      ],
    );
  }

  Expanded dateField(String title, String subtitle, [bool isCheckIn = false]) {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(6)),
      padding: isCheckIn
          ? const EdgeInsets.only(left: 20, top: 10)
          : const EdgeInsets.only(right: 20, top: 10),
      child: Column(
        crossAxisAlignment:
            isCheckIn ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        // mainAxisAlignment: MainAxisAlignment.s,
        children: [
          Text(title,
              style: AppText.mediumLight
                  .copyWith(fontSize: 13, color: Colors.grey)),
          const SizedBox(height: 6),
          Text(subtitle,
              style: AppText.mediumLight.copyWith(color: Colors.black))
        ],
      ),
    ));
  }

  String formatDate(DateTime date) {
    final formatter = DateFormat('MMM-dd-yyyy');
    return formatter.format(date);
  }
}
