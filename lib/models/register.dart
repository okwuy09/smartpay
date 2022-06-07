// To parse this JSON data, do
//
//     final registerUser = registerUserFromJson(jsonString);
import 'dart:convert';

RegisterUser registerUserFromJson(String str) =>
    RegisterUser.fromJson(json.decode(str));

String registerUserToJson(RegisterUser data) => json.encode(data.toJson());

class RegisterUser {
  RegisterUser({
    required this.status,
    required this.message,
    required this.data,
    required this.meta,
    required this.pagination,
  });

  bool status;
  String message;
  Data data;
  List<dynamic> meta;
  List<dynamic> pagination;

  factory RegisterUser.fromJson(Map<String, dynamic> json) => RegisterUser(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
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

class Data {
  Data({
    required this.user,
    required this.token,
  });

  UserRegister user;
  String token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: UserRegister.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
      };
}

class UserRegister {
  UserRegister({
    required this.fullName,
    this.username,
    required this.email,
    this.country,
    this.id,
    required this.deviceName,
    required this.password,
  });

  String fullName;
  String? username;
  String email;
  String? country;
  String? id;
  String password;
  String deviceName;

  factory UserRegister.fromJson(Map<String, dynamic> json) => UserRegister(
        fullName: json["full_name"],
        username: json["username"],
        email: json["email"],
        country: json["country"],
        id: json["id"],
        deviceName: json["device_name"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "username": username,
        "email": email,
        "country": country,
        "id": id,
        "device_name": deviceName,
        "password": password
      };
}
