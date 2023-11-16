// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:east_stay/blocs/bookin_bloc/booking_bloc.dart';
import 'package:east_stay/models/room_model.dart';
import 'package:east_stay/resources/components/app_textfield.dart';
import 'package:east_stay/resources/components/button.dart';
import 'package:east_stay/resources/components/payment_methods.dart';
import 'package:east_stay/resources/components/subtitle.dart';
import 'package:east_stay/resources/constants/colors.dart';
import 'package:east_stay/utils/snack_bar.dart';
import 'package:east_stay/utils/validations.dart';
import 'package:east_stay/views/parent_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenPayment extends StatelessWidget {
  ScreenPayment({super.key, required this.hotel});

  final Hotel hotel;
  final bookingFormKey = GlobalKey<FormState>();
  final addressController = TextEditingController();
  final mobileController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: bookingFormKey,
        child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            children: [
              const SubTitle('Personal Details', fontSize: 16, padding: 0),
              const SizedBox(height: 20),
              AppTextField(
                label: 'Mobile Number',
                controller: mobileController,
                validator: (value) =>
                    Validations.isNumber(value, 'mobile number'),
              ),
              SizedBox(height: 15),
              AppTextField(
                label: 'Address',
                minLine: 3,
                controller: addressController,
                validator: (value) => Validations.isEmpty(value, 'Address'),
              ),
              const SizedBox(height: 20),
              Divider(color: AppColor.grey[300], height: 0, thickness: 2),
              const SizedBox(height: 20),
              const SubTitle('Payment Method', fontSize: 16, padding: 0),
              const SizedBox(height: 20),
              PaymentMethod(),
              const SizedBox(height: 30),
            ]),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<RoomBookingBloc, BookingState>(
          listener: (context, state) {
            if (state is RoomBookedSuccessState) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => ScreenParant()),
                  (route) => false);
              MessageViewer.showSnackBar(context, 'Your room has been booked.');
            } else if (state is BookingFailedState) {
              MessageViewer.showSnackBar(
                  context, 'Room is not available an this moment', true);
            }
          },
          builder: (context, state) {
            return PrimaryButton(
              label: 'Proceed',
              onTap: () {
                if (bookingFormKey.currentState!.validate()) {
                  context.read<RoomBookingBloc>().add(SetRoomEvent(
                        mobileNumber: mobileController.text.trim(),
                        address: addressController.text.trim(),
                        hotel: hotel,
                      ));
                }
              },
            );
          },
        ),
      ),
    );
  }
}
