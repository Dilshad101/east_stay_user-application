import 'package:east_stay/blocs/booked_room_bloc/booked_room_bloc.dart';
import 'package:east_stay/resources/components/booking_details.tile.dart';
import 'package:east_stay/resources/constants/colors.dart';
import 'package:east_stay/resources/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenBookingHistory extends StatelessWidget {
  const ScreenBookingHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('your Bookings'),
          bottom: tabBar(),
        ),
        body: TabBarView(
          children: [
            checkedOutBookings(),
            upcomingBookings(),
          ],
        ),
      ),
    );
  }

  TabBar tabBar() {
    return TabBar(
      unselectedLabelStyle: AppText.mediumdark,
      labelStyle: AppText.mediumdark,
      labelColor: AppColor.secondaryColor,
      unselectedLabelColor: Colors.grey,
      indicatorColor: AppColor.primaryColor,
      tabs: const [Tab(text: 'Checked out'), Tab(text: 'Upcoming')],
    );
  }

  Widget upcomingBookings() {
    return BlocBuilder<BookedRoomBloc, BookedRoomState>(
      buildWhen: (previous, current) => current is! BookedRoomActionState,
      builder: (context, state) {
        if (state is BookedRoomFetchedState) {
          return state.upcomingBookings.isNotEmpty
              ? ListView.separated(
                  padding: const EdgeInsets.all(20),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => BookingDetailsTile(
                    bookedRoom: state.upcomingBookings[index],
                    showCancel: true,
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                  itemCount: state.upcomingBookings.length,
                )
              : Center(
                  child: Text(
                    'You have no Upcoming Bookings',
                    style: AppText.mediumLight.copyWith(color: Colors.grey),
                  ),
                );
        } else if (state is BookedRoomFetchedErrorState) {
          return Center(
              child: Text(
            state.message,
            style: AppText.mediumLight.copyWith(color: Colors.grey),
          ));
        }
        return const SizedBox();
      },
    );
  }

  Widget checkedOutBookings() {
    return BlocBuilder<BookedRoomBloc, BookedRoomState>(
      buildWhen: (previous, current) => current is! BookedRoomActionState,
      builder: (context, state) {
        if (state is BookedRoomFetchedState) {
          return state.bookedrooms.isEmpty
              ? Center(
                  child: Text('You have no checked out Rooms',
                      style: AppText.mediumLight.copyWith(color: Colors.grey)))
              : ListView.separated(
                  padding: const EdgeInsets.all(20),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => BookingDetailsTile(
                    bookedRoom: state.bookedrooms[index],
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                  itemCount: state.bookedrooms.length,
                );
        } else if (state is BookedRoomFetchedErrorState) {
          return Center(
              child: Text(
            state.message,
            style: AppText.mediumLight.copyWith(color: Colors.grey),
          ));
        }
        return const SizedBox();
      },
    );
  }
}
