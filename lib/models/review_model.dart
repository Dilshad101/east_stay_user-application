import 'package:intl/intl.dart';

class ReviewModel {
  String id;
  String roomId;
  String userId;
  String reviewer;
  String vendorId;
  String feedback;
  String stars;
  double avgRating;
  String date;

  ReviewModel({
    required this.id,
    required this.roomId,
    required this.userId,
    required this.reviewer,
    required this.vendorId,
    required this.feedback,
    required this.stars,
    required this.avgRating,
    required this.date,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    DateTime originalDate = DateTime.parse(json['createdAt']);
    String formattedDate =
        DateFormat('MMM dd yyyy', 'en_US').format(originalDate);
    return ReviewModel(
      id: json['_id'],
      roomId: json['roomId'],
      userId: json['userId']['_id']??'userId',
      reviewer: json['userId']?['name'] ?? 'User',
      vendorId: json['vendorId'],
      feedback: json['feedback'],
      stars: json['stars'],
      date: formattedDate,
      avgRating: 0,
    );
  }
}
