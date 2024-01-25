// To parse this JSON data, do
//
//     final chnagePasswordResponse = chnagePasswordResponseFromJson(jsonString);

import 'dart:convert';

ChangePasswordResponse chnagePasswordResponseFromJson(String str) => ChangePasswordResponse.fromJson(json.decode(str));

String chnagePasswordResponseToJson(ChangePasswordResponse data) => json.encode(data.toJson());

class ChangePasswordResponse {
  ChangePasswordResponse({
    this.status,
    this.message,
  });

  bool? status;
  String? message;

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) => ChangePasswordResponse(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
