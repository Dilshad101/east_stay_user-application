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
// {status: success, booked: {roomId: 641368e3bee1d1efbc62e3a7,
//userId: 63fe0c940157b2ccdf966c54,
//vendorId: 63fe12010157b2ccdf966ca0,
//adult: 700,
//rooms: 1,
//location: calicut,
//checkIn: 2023-11-06T00:00:00.000,
//checkOut: 2023-11-08T00:00:00.000,
//RoomPrice: 700, type:
//classic, total: 700,
//address: sjadfnasjkakjsf,
//phone: 9879879879,
//place: Kollam,
//days: 1,
//isCancel: false,
// _id: 65490cb6619853e55779efc5,}}

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'roomId': room.toJson(),
      'vendor': vendor,
      'checkIn': checkIn.toIso8601String(),
      'checkOut': checkOut.toIso8601String(),
      'RoomPrice': roomPrice,
      'type': type,
      'total': total,
      'address': address,
      'phone': phone,
      'place': place,
      'days': days,
      'isCancel': isCancel,
    };
  }
}
