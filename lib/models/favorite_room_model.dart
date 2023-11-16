import 'package:east_stay/models/room_model.dart';

class FavoriteRoom {
  final String id;
  final String userId;
  final String vendorId;
  final Hotel room;

  FavoriteRoom({
    required this.id,
    required this.userId,
    required this.vendorId,
    required this.room,
  });

  factory FavoriteRoom.fromJson(json, Hotel favRoom) {
    return FavoriteRoom(
      id: json['_id'],
      userId: json['userId'],
      vendorId: json['vendorId'],
      room: favRoom,
    );
  }
}
