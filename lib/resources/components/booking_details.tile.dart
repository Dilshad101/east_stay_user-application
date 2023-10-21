// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:east_stay/resources/constants/colors.dart';
import 'package:east_stay/resources/constants/text_style.dart';
import 'package:east_stay/resources/components/button.dart';
import 'package:east_stay/resources/components/star_rater.dart';
import 'package:flutter/material.dart';

class BookingDetailsTile extends StatelessWidget {
  const BookingDetailsTile({
    super.key,
    this.onCancelRoom,
  });
  final VoidCallback? onCancelRoom;

  @override
  Widget build(BuildContext context) {
    final dwidth = MediaQuery.sizeOf(context).width;
    return Container(
      height: 180,
      padding: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 100,
                width: dwidth * .35,
                margin: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: AppColor.grey[300],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hotel Paragon',
                      style: AppText.largeDark,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Calicut Kinfra',
                      style: AppText.small,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Check In : 04/12/2015',
                      style: AppText.small,
                    ),
                    Text(
                      'Check Out : 04/12/2015',
                      style: AppText.small,
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          onCancelRoom != null
              ? Expanded(
                  child: Column(
                    children: [
                      Divider(
                        color: AppColor.grey[600],
                        height: 0,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: onCancelRoom,
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
                      )
                    ],
                  ),
                )
              : Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => showRatingBottomSheet(context, dwidth),
                          child: Container(
                            margin: EdgeInsets.only(top: 5),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(6)),
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
                        child: Container(
                          margin: EdgeInsets.only(top: 5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(6)),
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
                      )
                    ],
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
              onChanged: (p0) {
                rate = p0;
              },
            ),
            SizedBox(height: 20),
            TextField(
              maxLines: 3,
              minLines: 1,
              cursorColor: AppColor.grey[700],
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Tell us your experience',
              ),
            ),
            SizedBox(height: 20),
            PrimaryButton(label: 'Done'),
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
}
