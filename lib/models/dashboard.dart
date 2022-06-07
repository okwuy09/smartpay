// To parse this JSON data, do
//
//     final dashboard = dashboardFromJson(jsonString);

import 'dart:convert';

Dashboard dashboardFromJson(String str) => Dashboard.fromJson(json.decode(str));

String dashboardToJson(Dashboard data) => json.encode(data.toJson());

class Dashboard {
  Dashboard({
    required this.status,
    required this.message,
    required this.data,
    required this.meta,
    required this.pagination,
  });

  bool status;
  String message;
  SecretData data;
  List<dynamic> meta;
  List<dynamic> pagination;

  factory Dashboard.fromJson(Map<String, dynamic> json) => Dashboard(
        status: json["status"],
        message: json["message"],
        data: SecretData.fromJson(json["data"]),
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

class SecretData {
  SecretData({
    required this.secret,
  });

  String secret;

  factory SecretData.fromJson(Map<String, dynamic> json) => SecretData(
        secret: json["secret"],
      );

  Map<String, dynamic> toJson() => {
        "secret": secret,
      };
}
