// To parse this JSON data, do
//
//     final driverOnlineOfflineResponse = driverOnlineOfflineResponseFromJson(jsonString);

import 'dart:convert';

DriverOnlineOfflineResponse driverOnlineOfflineResponseFromJson(String str) =>
    DriverOnlineOfflineResponse.fromJson(json.decode(str));

String driverOnlineOfflineResponseToJson(DriverOnlineOfflineResponse data) =>
    json.encode(data.toJson());

class DriverOnlineOfflineResponse {
  DriverOnlineOfflineResponse({
    required this.status,
    required this.message,
  });

  bool status;
  String message;

  factory DriverOnlineOfflineResponse.fromJson(Map<String, dynamic> json) =>
      DriverOnlineOfflineResponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
