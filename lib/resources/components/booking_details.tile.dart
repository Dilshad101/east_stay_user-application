// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:east_stay/blocs/booked_room_bloc/booked_room_bloc.dart';
import 'package:east_stay/models/booked_room_model.dart';
import 'package:east_stay/resources/constants/colors.dart';
import 'package:east_stay/resources/constants/text_style.dart';
import 'package:east_stay/resources/components/button.dart';
import 'package:east_stay/resources/components/star_rater.dart';
import 'package:east_stay/resources/loaders/shimmer.dart';
import 'package:east_stay/utils/snack_bar.dart';
import 'package:east_stay/views/booked_room_details_screen.dart';
import 'package:east_stay/views/room_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BookingDetailsTile extends StatelessWidget {
  BookingDetailsTile({
    super.key,
    this.showCancel = false,
    required this.bookedRoom,
  });
  final bool showCancel;
  final BookedRoom bookedRoom;
  final reviewController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final dwidth = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ScreenBookedRoomDetails(
                bookedRoom: bookedRoom,
                showCancel: showCancel,
              ))),
      child: Container(
        height: 155,
        padding: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
        ),
        child: Column(
          children: [
            body(dwidth),
            const SizedBox(height: 10),
            showCancel ? cancelroom(context) : rateUs(context, dwidth)
          ],
        ),
      ),
    );
  }

  Widget body(double dwidth) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 90,
          width: dwidth * .35,
          margin: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CachedNetworkImage(
              imageUrl: bookedRoom.room.img[0],
              placeholder: (context, url) => const ShimmerLoader(
                  height: double.maxFinite, width: double.maxFinite),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                bookedRoom.vendor.propertyName,
                style: AppText.largeDark,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '${bookedRoom.room.city} ${bookedRoom.room.state}',
                style: AppText.xSmall,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'Check In : ${formatDate(bookedRoom.checkIn)}',
                style: AppText.xSmall,
              ),
              Text(
                'Check Out : ${formatDate(bookedRoom.checkOut)}',
                style: AppText.xSmall,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget rateUs(BuildContext context, double dwidth) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => showRatingBottomSheet(context, dwidth),
              child: Container(
                margin: EdgeInsets.only(top: 5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(6)),
                  color: Color(0xffEFFFF1),
                ),
                child: Text(
                  'Rate Us',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff097500)),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ScreenRoomDetails(room: bookedRoom.room))),
              child: Container(
                margin: EdgeInsets.only(top: 5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(6)),
                  color: AppColor.primaryColor,
                ),
                child: Text(
                  'Book Again',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Expanded cancelroom(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Divider(
            color: AppColor.grey[400],
            height: 0,
          ),
          Expanded(
            child: BlocListener<BookedRoomBloc, BookedRoomState>(
              listenWhen: (previous, current) =>
                  current is BookedRoomActionState,
              listener: (context, state) {
                if (state is RoomCancelSuccessState) {
                  MessageViewer.showSnackBar(context, 'Room has been canceled');
                } else if (state is RoomCancelFailedState) {
                  MessageViewer.showSnackBar(context, state.message);
                }
              },
              child: GestureDetector(
                onTap: () {
                  context
                      .read<BookedRoomBloc>()
                      .add(CancelBookedRoomsEvent(bookId: bookedRoom.id));
                },
                child: Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Cancel Room',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void showRatingBottomSheet(BuildContext context, double width) {
    int rate = 0;
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
      backgroundColor: Colors.white,
      isScrollControlled: true, // Important
      context: context,
      builder: (context) => SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20),
            Text('Rate us', style: AppText.xLarge),
            SizedBox(height: 20),
            StarRater(
              rate: rate - 1,
              onChanged: (rating) {
                rate = rating;
              },
            ),
            SizedBox(height: 20),
            TextField(
              maxLines: 3,
              minLines: 1,
              controller: reviewController,
              cursorColor: AppColor.grey[700],
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Tell us your experience',
              ),
            ),
            SizedBox(height: 20),
            BlocListener<BookedRoomBloc, BookedRoomState>(
              listenWhen: (previous, current) =>
                  current is BookedRoomActionState,
              listener: (context, state) {
                if (state is RoomRatedSuccessState) {
                  Navigator.pop(context);
                  MessageViewer.showSnackBar(
                      context, 'Review added successfully');
                } else if (state is RoomRatedFailedState) {
                  Navigator.pop(context);
                  MessageViewer.showSnackBar(context, state.message, true);
                }
              },
              child: PrimaryButton(
                label: 'Done',
                onTap: () =>
                    context.read<BookedRoomBloc>().add(RateBookedRoomsEvent(
                          feedback: reviewController.text.trim(),
                          stars: rate.toString(),
                          roomId: bookedRoom.id,
                          vendorId: bookedRoom.vendor.id,
                        )),
              ),
            ),
            SizedBox(height: 20),
            AnimatedContainer(
              duration: Duration(microseconds: 200),
              // curve: Curves.linear,
              height: MediaQuery.of(context).viewInsets.bottom,
            ),
          ],
        ),
      ),
    );
  }

  String formatDate(DateTime date) {
    final formatter = DateFormat('MMM-dd-yyyy');
    return formatter.format(date);
  }
}
