import 'package:east_stay/models/review_model.dart';
import 'package:east_stay/resources/components/review_tile.dart';
import 'package:flutter/material.dart';

class ScreenViewAllReview extends StatelessWidget {
  const ScreenViewAllReview({super.key, required this.reviews});
  final List<ReviewModel> reviews;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Reviews')),
      body: ListView.separated(
          padding: const EdgeInsets.all(20),
          itemBuilder: (context, index) =>
              ReviewTile(reviewer: reviews[index], showDetails: true),
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: reviews.length),
    );
  }
}
