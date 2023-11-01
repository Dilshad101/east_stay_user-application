import 'package:cached_network_image/cached_network_image.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:east_stay/blocs/bookin_bloc/booking_bloc.dart';
import 'package:east_stay/models/room_model.dart';
import 'package:east_stay/resources/constants/colors.dart';
import 'package:east_stay/resources/constants/text_style.dart';
import 'package:east_stay/resources/components/booking_count_field.dart';
import 'package:east_stay/resources/components/button.dart';
import 'package:east_stay/resources/components/custom_text_field.dart';
import 'package:east_stay/resources/components/payment_methods.dart';
import 'package:east_stay/resources/components/price_details.dart';
import 'package:east_stay/resources/components/subtitle.dart';
import 'package:east_stay/resources/loaders/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ScreenBooking extends StatelessWidget {
  ScreenBooking({super.key, required this.hotel});
  final Hotel hotel;
  final dateController = TextEditingController();
  final guestNotifier = ValueNotifier(1);
  final roomNotifier = ValueNotifier(1);
  @override
  Widget build(BuildContext context) {
    final bookingbloc = context.read<RoomBookingBloc>();
    final dheight = MediaQuery.sizeOf(context).height;
    final dwidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: appBar(context),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          hotelOverView(dheight, dwidth),
          const SizedBox(height: 20),
          Divider(color: AppColor.grey[300], height: 0, thickness: 2),
          yourRooms(context, bookingbloc),
          const SizedBox(height: 20),
          PriceDetails(hotel),
          const SizedBox(height: 20),
          Divider(color: AppColor.grey[300], height: 0, thickness: 2),
          const SizedBox(height: 20),
          const SubTitle('Payment Method', fontSize: 16),
          const SizedBox(height: 20),
          PaymentMethod(),
          const SizedBox(height: 20),
          const PrimaryButton(label: 'Book now', margin: 20),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget hotelOverView(double dheight, double dwidth) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: dheight * .12,
          width: dwidth * .35,
          margin: const EdgeInsets.only(left: 20),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CachedNetworkImage(
              imageUrl: hotel.img[0],
              placeholder: (context, url) => const ShimmerLoader(
                height: double.maxFinite,
                width: double.maxFinite,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                hotel.vendor.propertyName,
                style: AppText.largeDark,
                overflow: TextOverflow.ellipsis,
              ),
              Text('${hotel.city} ${hotel.state}',
                  style: AppText.smallDark, overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ],
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text('Booking Details'),
    );
  }

  Widget yourRooms(BuildContext context, RoomBookingBloc bookingBloc) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const SubTitle('Your Room', fontSize: 16),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text('Please Select Check In date and Check Out date',
                style:
                    AppText.smallLight.copyWith(color: AppColor.textSecondary)),
          ),
          const SizedBox(height: 5),
          CustomTextField(
            hint: 'select dates',
            icon: Icons.calendar_today_outlined,
            isReadOnly: true,
            controller: dateController,
            onTap: () => getDates(context, bookingBloc),
          ),
          const SizedBox(height: 20),
          BookingCount(
            numberNotifier: guestNotifier,
            icon: Icons.person_outline_rounded,
            label: 'Guest',
            limit: int.parse(hotel.capacity),
          ),
          const SizedBox(height: 20),
          BookingCount(
            numberNotifier: roomNotifier,
            icon: Icons.king_bed_outlined,
            label: 'Room',
            isGuest: false,
            limit: int.parse(hotel.totalRooms),
          ),
          const SizedBox(height: 20),
          Divider(color: AppColor.grey[300], height: 0, thickness: 2),
          const SizedBox(height: 20),
        ],
      );
  getDates(BuildContext context, RoomBookingBloc bookingBloc) async {
    final selectedDates = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
          calendarType: CalendarDatePicker2Type.range,
          selectedRangeHighlightColor: AppColor.primaryColor.withOpacity(.2),
          selectedDayHighlightColor: AppColor.primaryColor,
          firstDate: DateTime.now()),
      dialogSize: const Size(325, 400),
      value: [DateTime.now()],
      borderRadius: BorderRadius.circular(15),
    );
    if (selectedDates == null || selectedDates.isEmpty) return;
    final firstDate = selectedDates[0]!;
    final lastDate = selectedDates[selectedDates.length - 1]!;
    dateController.text = getFormatedDates(firstDate, lastDate);
    final startDate = DateTime(firstDate.year, firstDate.month, firstDate.day);
    final endDate = DateTime(lastDate.year, lastDate.month, lastDate.day);
    Duration difference = endDate.difference(startDate);
    int daysDifference = difference.inDays;
    bookingBloc.add(SelectBookingDatesEvent(
        checkin: startDate.toIso8601String(),
        checkout: endDate.toIso8601String(),
        numberOfDays: daysDifference));
  }

  String getFormatedDates(DateTime date1, DateTime date2) {
    final formatter = DateFormat('MMM-dd-yyyy');
    return '${formatter.format(date1)}  To  ${formatter.format(date2)}';
  }
}
