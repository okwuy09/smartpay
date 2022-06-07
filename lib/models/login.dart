// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({
    required this.status,
    required this.message,
    required this.data,
    required this.meta,
    required this.pagination,
  });

  bool status;
  String message;
  UserData data;
  List<dynamic> meta;
  List<dynamic> pagination;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        status: json["status"],
        message: json["message"],
        data: UserData.fromJson(json["data"]),
        meta: List<dynamic>.from(json["meta"].map((x) => x)),
        pagination: List<dynamic>.from(json["pagination"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
        "meta": List<dynamic>.from(meta.map((x) => x)),
        "pagination": List<dynamic>.from(pagination.map((x) => x)),
      };
}

class UserData {
  UserData({
    required this.user,
    required this.token,
  });

  User user;
  String token;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        user: User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
      };
}

class User {
  User({
    this.id,
    this.fullName,
    this.username,
    required this.email,
    required this.password,
    this.phoneCountry,
    this.country,
    this.avatar,
    this.deviceName,
  });

  String? id;
  String? fullName;
  String? username;
  String email;
  dynamic password;
  dynamic phoneCountry;
  String? country;
  dynamic avatar;
  String? deviceName;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fullName: json["full_name"],
        username: json["username"],
        email: json["email"],
        password: json["phone"],
        phoneCountry: json["phone_country"],
        country: json["country"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        // "full_name": fullName,
        // "username": username,
        "email": email,
        "password": password,
        "device_name": deviceName,
        // "phone_country": phoneCountry,
        // "country": country,
        // "avatar": avatar,
      };
}
