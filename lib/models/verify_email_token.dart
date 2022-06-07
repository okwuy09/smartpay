// To parse this JSON data, do
//
//     final verifyEmailToken = verifyEmailTokenFromJson(jsonString);
import 'dart:convert';

VerifyEmailToken verifyEmailTokenFromJson(String str) =>
    VerifyEmailToken.fromJson(json.decode(str));

String verifyEmailTokenToJson(VerifyEmailToken data) =>
    json.encode(data.toJson());

class VerifyEmailToken {
  VerifyEmailToken({
    required this.status,
    required this.message,
    required this.data,
    required this.meta,
    required this.pagination,
  });

  bool status;
  String message;
  VerifyToken data;
  List<dynamic> meta;
  List<dynamic> pagination;

  factory VerifyEmailToken.fromJson(Map<String, dynamic> json) =>
      VerifyEmailToken(
        status: json["status"],
        message: json["message"],
        data: VerifyToken.fromJson(json["data"]),
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

class VerifyToken {
  VerifyToken({
    required this.email,
    required this.token,
  });

  String email;
  String? token;

  factory VerifyToken.fromJson(Map<String, dynamic> json) => VerifyToken(
        email: json["email"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "token": token,
      };
}
