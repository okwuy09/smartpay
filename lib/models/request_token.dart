// To parse this JSON data, do
//
//     final requestToken = requestTokenFromJson(jsonString);
import 'dart:convert';

RequestToken requestTokenFromJson(String str) =>
    RequestToken.fromJson(json.decode(str));

String requestTokenToJson(RequestToken data) => json.encode(data.toJson());

class RequestToken {
  RequestToken({
    required this.status,
    required this.message,
    required this.data,
    required this.meta,
    required this.pagination,
  });

  bool status;
  String message;
  TokenData data;
  List<dynamic> meta;
  List<dynamic> pagination;

  factory RequestToken.fromJson(Map<String, dynamic> json) => RequestToken(
        status: json["status"],
        message: json["message"],
        data: TokenData.fromJson(json["data"]),
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

class TokenData {
  TokenData({
    required this.email,
  });

  String email;

  factory TokenData.fromJson(Map<String, dynamic> json) => TokenData(
        email: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
      };
}
