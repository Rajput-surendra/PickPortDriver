// To parse this JSON data, do
//
//     final paymentHistoryResponse = paymentHistoryResponseFromJson(jsonString);

import 'dart:convert';

PaymentHistoryResponse paymentHistoryResponseFromJson(String str) => PaymentHistoryResponse.fromJson(json.decode(str));

String paymentHistoryResponseToJson(PaymentHistoryResponse data) => json.encode(data.toJson());

class PaymentHistoryResponse {
  PaymentHistoryResponse({
    this.status,
    this.message,
    this.basePath,
    this.data,
  });

  bool? status;
  String? message;
  String? basePath;
  List<PaymentHistoryDataList>? data;

  factory PaymentHistoryResponse.fromJson(Map<String, dynamic> json) => PaymentHistoryResponse(
    status: json["status"],
    message: json["message"],
    basePath: json["base_path"],
    data: List<PaymentHistoryDataList>.from(json["data"].map((x) => PaymentHistoryDataList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "base_path": basePath,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class PaymentHistoryDataList {
  PaymentHistoryDataList({
    this.id,
    this.userId,
    this.parcelId,
    this.amount,
    this.attachment,
    this.status,
    this.createDt,
    this.updateDt,
  });

  String? id;
  String? userId;
  String? parcelId;
  String? amount;
  String? attachment;
  String? status;
  String? createDt;
  String? updateDt;

  factory PaymentHistoryDataList.fromJson(Map<String, dynamic> json) => PaymentHistoryDataList(
    id: json["id"],
    userId: json["user_id"],
    parcelId: json["parcel_id"],
    amount: json["amount"],
    attachment: json["attachment"],
    status: json["status"],
    createDt: json["create_dt"],
    updateDt: json["update_dt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "parcel_id": parcelId,
    "amount": amount,
    "attachment": attachment,
    "status": status,
    "create_dt": createDt,
    "update_dt": updateDt,
  };
}
