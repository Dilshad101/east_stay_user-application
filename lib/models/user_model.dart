class User {
  String id;
  String name;
  String email;
  String password;
  String phone;
  String token;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.token
  });

  factory User.fromJson(Map<String, dynamic> json,token) {
    return User(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      token: token,
    );
  }
}
