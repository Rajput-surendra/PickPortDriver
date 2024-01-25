// To parse this JSON data, do
//
//     final parcelTransfferResponse = parcelTransfferResponseFromJson(jsonString);

import 'dart:convert';

ParcelTransferResponse parcelTransfferResponseFromJson(String str) => ParcelTransferResponse.fromJson(json.decode(str));

String parcelTransfferResponseToJson(ParcelTransferResponse data) => json.encode(data.toJson());

class ParcelTransferResponse {
  ParcelTransferResponse({
    this.status,
    this.message,
  });

  int? status;
  String? message;

  factory ParcelTransferResponse.fromJson(Map<String, dynamic> json) => ParcelTransferResponse(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
