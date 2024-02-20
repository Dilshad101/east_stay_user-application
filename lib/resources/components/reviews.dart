import 'package:east_stay/blocs/review_bloc/review_bloc.dart';
import 'package:east_stay/models/review_model.dart';
import 'package:east_stay/models/room_model.dart';
import 'package:east_stay/resources/components/review_tile.dart';
import 'package:east_stay/resources/components/subtitle.dart';
import 'package:east_stay/resources/constants/colors.dart';
import 'package:east_stay/resources/constants/text_style.dart';
import 'package:east_stay/views/view_all_review_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Reviews extends StatelessWidget {
  const Reviews({super.key, required this.room, this.singleUser = false});
  final Hotel room;
  final bool singleUser;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewBloc, ReviewState>(
      builder: (context, state) {
        if (state is ReviewFetchedSuccessState) {
          return Column(
            children: [
              singleUser
                  ? const SizedBox()
                  : _reviewTitle(state.reviews, context),
              _reviewList(state.reviews)
            ],
          );
        } else if (state is ReviewLoadingState) {
          return Center(
            child: LoadingAnimationWidget.waveDots(
                color: AppColor.primaryColor, size: 20),
          );
        } else if (state is ReviewEmptyState) {
          return singleUser
              ? SizedBox(
                  height: 100,
                  child: Center(
                    child: Text(
                      "You haven't added any reviews",
                      style: AppText.mediumLight.copyWith(color: Colors.grey),
                    ),
                  ),
                )
              : Column(
                  children: [
                    _reviewTitle(null, context),
                    SizedBox(
                      height: 100,
                      child: Center(
                        child: Text(
                          "No reviews are available for this room.",
                          style:
                              AppText.mediumLight.copyWith(color: Colors.grey),
                        ),
                      ),
                    )
                  ],
                );
        }
        return const SizedBox();
      },
    );
  }

  Widget _reviewTitle(List<ReviewModel>? reviews, BuildContext context) {
    return Row(
      children: [
        const SubTitle('Reviews'),
        const SizedBox(width: 5),
        reviews == null
            ? const SizedBox()
            : Expanded(
                child: Row(children: [
                  const Icon(
                    Icons.star,
                    color: AppColor.gold,
                    size: 20,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '(${reviews[0].avgRating})',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColor.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ScreenViewAllReview(reviews: reviews))),
                    child: const Text(
                      'View more',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                ]),
              ),
      ],
    );
  }

  Widget _reviewList(List<ReviewModel> reviews) {
    return reviews.isEmpty
        ? SizedBox(
            height: 100,
            child: Center(
              child: Text(
                "No reviews for this room",
                style: AppText.mediumLight.copyWith(color: Colors.grey),
              ),
            ),
          )
        : ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            itemBuilder: (context, index) {
              final reviewer = reviews[index];
              return ReviewTile(reviewer: reviewer);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: reviews.length,
          );
  }
}
