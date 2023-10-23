// import 'package:east_stay/models/coupons.dart';

import 'vendor_model.dart';

class Hotel {
  String id;
  Vendor vendor;
  String address;
  String city;
  String state;
  String zip;
  List<String> img;
  String propertyType;
  String description;
  String price;
  String capacity;
  String? totalRoomRate;
  String totalRooms;
  String adultsRate;
  String location;
  String longitude;
  double latitude;
  String category;
  List<String> amenities;
  String? parking;
  bool isApproved;
  bool isBanned;

  Hotel({
    required this.id,
    required this.vendor,
    required this.address,
    required this.city,
    required this.state,
    required this.zip,
    required this.img,
    required this.propertyType,
    required this.description,
    required this.price,
    required this.capacity,
    this.totalRoomRate,
    required this.totalRooms,
    required this.adultsRate,
    required this.location,
    required this.longitude,
    required this.latitude,
    required this.category,
    required this.amenities,
    this.parking,
    required this.isApproved,
    required this.isBanned,
  });

  factory Hotel.fromJson(Map<String, dynamic> json, ) {
    return Hotel(
      id: json['_id'],
      vendor: Vendor.fromJson(json['vendorId']),
      address: json['address'],
      city: json['city'],
      state: json['state'],
      zip: json['zip'],
      img: List<String>.from(json['img']),
      propertyType: json['propertyType'],
      description: json['description'],
      price: json['price'],
      capacity: json['capacity'],
      totalRoomRate: json['totalRoomRate'],
      totalRooms: json['totalrooms'],
      adultsRate: json['AdultsRate'],
      location: json['location'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      category: json['category'],
      amenities: List<String>.from(json['amenities']),
      parking: json['parking'],
      isApproved: json['isApproved'],
      isBanned: json['isBanned'],
    );
  }
  Map<String, dynamic> toJson() => {
        '_id': id,
        'vendorId': vendor.toJson(),
        'address': address,
        'city': city,
        'state': state,
        'zip': zip,
        'img': img,
        'propertyType': propertyType,
        'description': description,
        'price': price,
        'capacity': capacity,
        'totalRoomRate': totalRoomRate,
        'totalrooms': totalRooms,
        'AdultsRate': adultsRate,
        'location': location,
        'longitude': longitude,
        'latitude': latitude,
        'category': category,
        'amenities': amenities,
        'parking': parking,
        'isApproved': isApproved,
        'isBanned': isBanned,
      };
}
