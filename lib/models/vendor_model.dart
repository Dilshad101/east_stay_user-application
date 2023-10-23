
class Vendor {
  String id;
  String name;
  String email;
  String password;
  String propertyName;
  String propertyLocation;
  String phone;
  bool isBanned;
  String image;

  Vendor({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.propertyName,
    required this.propertyLocation,
    required this.phone,
    required this.isBanned,
    required this.image,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      propertyName: json['propertyName'],
      propertyLocation: json['propertyLocation'],
      phone: json['phone'],
      isBanned: json['isBanned'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'email': email,
        'password': password,
        'propertyName': propertyName,
        'propertyLocation': propertyLocation,
        'phone': phone,
        'isBanned': isBanned,
        'image': image,
      };
}
