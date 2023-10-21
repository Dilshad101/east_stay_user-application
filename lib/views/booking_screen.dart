import 'package:east_stay/resources/constants/colors.dart';
import 'package:east_stay/resources/constants/text_style.dart';
import 'package:east_stay/resources/components/booking_details_field.dart';
import 'package:east_stay/resources/components/button.dart';
import 'package:east_stay/resources/components/custom_text_field.dart';
import 'package:east_stay/resources/components/payment_methods.dart';
import 'package:east_stay/resources/components/price_details.dart';
import 'package:east_stay/resources/components/subtitle.dart';
import 'package:flutter/material.dart';

class ScreenBooking extends StatelessWidget {
  const ScreenBooking({super.key});

  @override
  Widget build(BuildContext context) {
    final dheight = MediaQuery.sizeOf(context).height;
    final dwidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        title: const Text('Booking Details'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: dheight * .12,
                width: dwidth * .35,
                margin: const EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: AppColor.grey,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hotel Paragon',
                      style: AppText.largeDark,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text('Calicut Kerala',
                        style: AppText.mediumdark,
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Divider(color: AppColor.grey[300], height: 0, thickness: 2),
          const SizedBox(height: 20),
          // Text('Your Room'),
          const SubTitle('Your Room', fontSize: 16),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Please Select Check In date and Check Out date',
              style: TextStyle(
                fontSize: 12,
                color: AppColor.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: 5),
          const CustomTextField(
            hint: 'Dates',
            icon: Icons.calendar_today_outlined,
            isReadOnly: true,
          ),
          const SizedBox(height: 20),
          const BookingDetail(
              icon: Icons.person_outline_rounded, label: 'Guest'),
          const SizedBox(height: 20),
          const BookingDetail(icon: Icons.king_bed_outlined, label: 'Room'),
          const SizedBox(height: 20),
          Divider(color: AppColor.grey[300], height: 0, thickness: 2),
          const SizedBox(height: 20),
          const PriceDetails(),
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
}
