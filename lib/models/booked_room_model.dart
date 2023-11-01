import 'package:east_stay/models/room_model.dart';
import 'package:east_stay/models/vendor_model.dart';

class BookedRoom {
  String id;
  Hotel room;
  Vendor vendor;
  DateTime checkIn;
  DateTime checkOut;
  int roomPrice;
  String type;
  int total;
  String address;
  int phone;
  String place;
  int days;
  bool isCancel;

  BookedRoom({
    required this.id,
    required this.room,
    required this.vendor,
    required this.checkIn,
    required this.checkOut,
    required this.roomPrice,
    required this.type,
    required this.total,
    required this.address,
    required this.phone,
    required this.place,
    required this.days,
    required this.isCancel,
  });

  factory BookedRoom.fromJson(Map<String, dynamic> json) {
    final roomdata = json['roomId'];
    roomdata['vendorId'] = json['vendorId'];
    return BookedRoom(
      id: json['_id'],
      room: Hotel.fromJson(roomdata),
      vendor: Vendor.fromJson(json['vendorId']),
      checkIn: DateTime.parse(json['checkIn']),
      checkOut: DateTime.parse(json['checkOut']),
      roomPrice: json['RoomPrice'],
      type: json['type'],
      total: json['total'],
      address: json['address'],
      phone: json['phone'],
      place: json['place'],
      days: json['days'],
      isCancel: json['isCancel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      // 'roomId': room.toJson(),
      // 'vendor': vendor,
      // 'checkIn': checkIn.toIso8601String(),
      // 'checkOut': checkOut.toIso8601String(),
      // 'RoomPrice': roomPrice,
      // 'type': type,
      // 'total': total,
      // 'address': address,
      // 'phone': phone,
      // 'place': place,
      // 'days': days,
      // 'isCancel': isCancel,
    };
  }
}
