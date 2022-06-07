// To parse this JSON data, do
//
//     final logOut = logOutFromJson(jsonString);

import 'dart:convert';

LogOut logOutFromJson(String str) => LogOut.fromJson(json.decode(str));

String logOutToJson(LogOut data) => json.encode(data.toJson());

class LogOut {
  LogOut({
    required this.status,
    required this.message,
    required this.data,
    required this.meta,
    required this.pagination,
  });

  bool status;
  String message;
  List<dynamic> data;
  List<dynamic> meta;
  List<dynamic> pagination;

  factory LogOut.fromJson(Map<String, dynamic> json) => LogOut(
        status: json["status"],
        message: json["message"],
        data: List<dynamic>.from(json["data"].map((x) => x)),
        meta: List<dynamic>.from(json["meta"].map((x) => x)),
        pagination: List<dynamic>.from(json["pagination"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x)),
        "meta": List<dynamic>.from(meta.map((x) => x)),
        "pagination": List<dynamic>.from(pagination.map((x) => x)),
      };
}
