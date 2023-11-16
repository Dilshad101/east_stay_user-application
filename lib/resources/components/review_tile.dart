import 'package:east_stay/models/review_model.dart';
import 'package:east_stay/resources/constants/colors.dart';
import 'package:east_stay/resources/constants/text_style.dart';
import 'package:flutter/material.dart';

class ReviewTile extends StatelessWidget {
  const ReviewTile({
    super.key,
    required this.reviewer,
    this.showDetails = false,
  });
  final ReviewModel reviewer;
  final bool showDetails;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: showDetails ? () => showDetailedReview(context) : null,
      child: Container(
        // height: 110,
        width: double.maxFinite,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
        ),
        child: Column(
          children: [
            _header(),
            const SizedBox(height: 5),
            feedBack(),
          ],
        ),
      ),
    );
  }

  Text feedBack({bool inSnackBar = false}) {
    return Text(
      reviewer.feedback,
      style: AppText.smallDark,
      maxLines: !inSnackBar ? 2 : null,
      textAlign: TextAlign.start,
      overflow: inSnackBar ? TextOverflow.clip : TextOverflow.ellipsis,
    );
  }

  SizedBox _header() {
    return SizedBox(
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: AppColor.grey,
            ),
            child: Text(
              reviewer.reviewer[0],
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 5),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(reviewer.reviewer, style: AppText.mediumdark),
              Text(reviewer.date,
                  style: const TextStyle(
                      fontSize: 12, color: AppColor.textSecondary)),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50), color: AppColor.gold),
            child: Row(
              children: [
                const Icon(
                  Icons.star,
                  color: AppColor.secondaryColor,
                  size: 16,
                ),
                const SizedBox(width: 5),
                Text(
                  reviewer.stars,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColor.textPrimary,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void showDetailedReview(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) =>
          SimpleDialog(contentPadding: const EdgeInsets.all(10), children: [
        Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close, size: 20))),
        const SizedBox(height: 20),
        _header(),
        const SizedBox(height: 20),
        feedBack(inSnackBar: true),
      ]),
    );
  }
}
