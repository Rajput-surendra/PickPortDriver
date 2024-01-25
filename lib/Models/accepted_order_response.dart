// To parse this JSON data, do
//
//     final acceptedOrderResponse = acceptedOrderResponseFromJson(jsonString);

import 'dart:convert';

AcceptedOrderResponse acceptedOrderResponseFromJson(String str) => AcceptedOrderResponse.fromJson(json.decode(str));

String acceptedOrderResponseToJson(AcceptedOrderResponse data) => json.encode(data.toJson());

class AcceptedOrderResponse {
  AcceptedOrderResponse({
    required this.status,
    required this.errorCode,
    required this.errorLine,
    required this.message,
     this.data,
  });

  int status;
  int errorCode;
  int errorLine;
  String message;
  List<AccepetedOrderList>? data;

  factory AcceptedOrderResponse.fromJson(Map<String, dynamic> json) => AcceptedOrderResponse(
    status: json["status"],
    errorCode: json["error_code"],
    errorLine: json["error_line"],
    message: json["message"],
    data: List<AccepetedOrderList>.from(json["data"].map((x) => AccepetedOrderList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "error_code": errorCode,
    "error_line": errorLine,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AccepetedOrderList {
  AccepetedOrderList({
    required this.orderId,
    required this.userId,
    required this.senderName,
    required this.senderAddress,
    required this.senderFulladdress,
    required this.orderAmount,
    required this.paymentMethod,
    required this.phoneNo,
    required this.isPaid,
    required this.senderLatitude,
    required this.senderLongitude,
    required this.onDate,
    required this.deliveryTimeFrom,
    required this.saleIds,
    required this.parcelDetails,
  });

  String orderId;
  String userId;
  String senderName;
  String senderAddress;
  String senderFulladdress;
  String orderAmount;
  String paymentMethod;
  String phoneNo;
  String isPaid;
  String senderLatitude;
  String senderLongitude;
  DateTime onDate;
  String deliveryTimeFrom;
  String saleIds;
  List<ParcelDetail> parcelDetails;

  factory AccepetedOrderList.fromJson(Map<String, dynamic> json) => AccepetedOrderList(
    orderId: json["order_id"],
    userId: json["user_id"],
    senderName: json["sender_name"],
    senderAddress: json["sender_address"],
    senderFulladdress: json["sender_fulladdress"],
    orderAmount: json["order_amount"],
    paymentMethod: json["payment_method"],
    phoneNo: json["phone_no"],
    isPaid: json["is_paid"],
    senderLatitude: json["sender_latitude"],
    senderLongitude: json["sender_longitude"],
    onDate: DateTime.parse(json["on_date"]),
    deliveryTimeFrom: json["delivery_time_from"],
    saleIds: json["sale_ids"],
    parcelDetails: List<ParcelDetail>.from(json["parcel_details"].map((x) => ParcelDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "user_id": userId,
    "sender_name": senderName,
    "sender_address": senderAddress,
    "sender_fulladdress": senderFulladdress,
    "order_amount": orderAmount,
    "payment_method": paymentMethod,
    "phone_no": phoneNo,
    "is_paid": isPaid,
    "sender_latitude": senderLatitude,
    "sender_longitude": senderLongitude,
    "on_date": onDate.toIso8601String(),
    "delivery_time_from": deliveryTimeFrom,
    "sale_ids": saleIds,
    "parcel_details": List<dynamic>.from(parcelDetails.map((x) => x.toJson())),
  };
}

class ParcelDetail {
  ParcelDetail({
    required this.saleId,
    required this.orderId,
    required this.barcode,
    required this.barcodeLink,
    required this.userId,
    required this.deliveryBoyId,
    required this.bookingRef,
    required this.senderName,
    required this.senderAddress,
    required this.senderFulladdress,
    required this.receiverName,
    required this.receiverPhone,
    required this.receiverAddress,
    required this.reqDeliveryboyIds,
    required this.onDate,
    required this.deliveryTimeFrom,
    required this.deliveryTimeTo,
    required this.slottime,
    required this.status,
    required this.note,
    required this.isPaid,
    required this.shippingCharge,
    required this.couponDiscount,
    required this.couponCode,
    required this.totalAmount,
    required this.totalRewards,
    required this.totalKg,
    required this.totalItems,
    required this.socityId,
    required this.addressId,
    required this.deliveryAddress,
    required this.area,
    required this.locationId,
    required this.deliveryCharge,
    required this.newStoreId,
    required this.assignTo,
    required this.paymentMethod,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNo,
    required this.zipCode,
    required this.dateTime,
    required this.deliveryboyOrderStatus,
    required this.assignedTime,
    required this.isStatus,
    required this.deliveryLatitude,
    required this.deliveryLongitude,
    required this.orderReceivedTime,
    required this.foodPrepareTime,
    required this.orderPickupTime,
    required this.orderDeliveredTime,
    required this.orderTimeComplete,
    required this.city,
    required this.distance,
    required this.reciverFullAddress,
    required this.senderLatitude,
    required this.senderLongitude,
    required this.receiverLatitude,
    required this.receiverLongitude,
    required this.parcelPhoto,
    required this.isCodOrderVerify,
    required this.accountName,
    required this.accountNumber,
    required this.parcelHistory,
    required this.materialInfo,
  });

  String saleId;
  String orderId;
  String barcode;
  String barcodeLink;
  String userId;
  String deliveryBoyId;
  String bookingRef;
  String senderName;
  String senderAddress;
  String senderFulladdress;
  String receiverName;
  String receiverPhone;
  String receiverAddress;
  String reqDeliveryboyIds;
  DateTime onDate;
  String deliveryTimeFrom;
  String deliveryTimeTo;
  String slottime;
  String status;
  String note;
  String isPaid;
  String shippingCharge;
  String couponDiscount;
  String couponCode;
  String totalAmount;
  String totalRewards;
  String totalKg;
  String totalItems;
  String socityId;
  String addressId;
  String deliveryAddress;
  String area;
  String locationId;
  String deliveryCharge;
  String newStoreId;
  String assignTo;
  String paymentMethod;
  String firstName;
  String lastName;
  String email;
  String phoneNo;
  String zipCode;
  String dateTime;
  String deliveryboyOrderStatus;
  String assignedTime;
  String isStatus;
  String deliveryLatitude;
  String deliveryLongitude;
  String orderReceivedTime;
  String foodPrepareTime;
  String orderPickupTime;
  String orderDeliveredTime;
  String orderTimeComplete;
  String city;
  String distance;
  String reciverFullAddress;
  String senderLatitude;
  String senderLongitude;
  DateTime receiverLatitude;
  String receiverLongitude;
  String parcelPhoto;
  String isCodOrderVerify;
  String accountName;
  String accountNumber;
  String parcelHistory;
  MaterialInfo materialInfo;

  factory ParcelDetail.fromJson(Map<String, dynamic> json) => ParcelDetail(
    saleId: json["sale_id"],
    orderId: json["order_id"],
    barcode: json["barcode"],
    barcodeLink: json["barcode_link"],
    userId: json["user_id"],
    deliveryBoyId: json["delivery_boy_id"],
    bookingRef: json["booking_ref"],
    senderName: json["sender_name"],
    senderAddress: json["sender_address"],
    senderFulladdress: json["sender_fulladdress"],
    receiverName: json["receiver_name"],
    receiverPhone: json["receiver_phone"],
    receiverAddress: json["receiver_address"],
    reqDeliveryboyIds: json["req_deliveryboy_ids"],
    onDate: DateTime.parse(json["on_date"]),
    deliveryTimeFrom: json["delivery_time_from"],
    deliveryTimeTo: json["delivery_time_to"],
    slottime: json["slottime"],
    status: json["status"],
    note: json["note"],
    isPaid: json["is_paid"],
    shippingCharge: json["shipping_charge"],
    couponDiscount: json["coupon_discount"],
    couponCode: json["coupon_code"],
    totalAmount: json["total_amount"],
    totalRewards: json["total_rewards"],
    totalKg: json["total_kg"],
    totalItems: json["total_items"],
    socityId: json["socity_id"],
    addressId: json["address_id"],
    deliveryAddress: json["delivery_address"],
    area: json["area"],
    locationId: json["location_id"],
    deliveryCharge: json["delivery_charge"],
    newStoreId: json["new_store_id"],
    assignTo: json["assign_to"],
    paymentMethod: json["payment_method"],
    firstName: json["First_name"],
    lastName: json["Last_name"],
    email: json["email"],
    phoneNo: json["phone_no"],
    zipCode: json["zip_code"],
    dateTime: json["date_time"],
    deliveryboyOrderStatus: json["deliveryboy_order_status"],
    assignedTime: json["assigned_time"],
    isStatus: json["is_status"],
    deliveryLatitude: json["delivery_latitude"],
    deliveryLongitude: json["delivery_longitude"],
    orderReceivedTime: json["order_received_time"],
    foodPrepareTime: json["food_prepare_time"],
    orderPickupTime: json["order_pickup_time"],
    orderDeliveredTime: json["order_delivered_time"],
    orderTimeComplete: json["order_time_complete"],
    city: json["city"],
    distance: json["distance"],
    reciverFullAddress: json["reciver_full_address"],
    senderLatitude: json["sender_latitude"],
    senderLongitude: json["sender_longitude"],
    receiverLatitude: DateTime.parse(json["receiver_latitude"]),
    receiverLongitude: json["receiver_longitude"],
    parcelPhoto: json["parcel_photo"],
    isCodOrderVerify: json["is_cod_order_verify"],
    accountName: json["account_name"],
    accountNumber: json["account_number"],
    parcelHistory: json["parcel_history"],
    materialInfo: MaterialInfo.fromJson(json["material_info"]),
  );

  Map<String, dynamic> toJson() => {
    "sale_id": saleId,
    "order_id": orderId,
    "barcode": barcode,
    "barcode_link": barcodeLink,
    "user_id": userId,
    "delivery_boy_id": deliveryBoyId,
    "booking_ref": bookingRef,
    "sender_name": senderName,
    "sender_address": senderAddress,
    "sender_fulladdress": senderFulladdress,
    "receiver_name": receiverName,
    "receiver_phone": receiverPhone,
    "receiver_address": receiverAddress,
    "req_deliveryboy_ids": reqDeliveryboyIds,
    "on_date": "${onDate.year.toString().padLeft(4, '0')}-${onDate.month.toString().padLeft(2, '0')}-${onDate.day.toString().padLeft(2, '0')}",
    "delivery_time_from": deliveryTimeFrom,
    "delivery_time_to": deliveryTimeTo,
    "slottime": slottime,
    "status": status,
    "note": note,
    "is_paid": isPaid,
    "shipping_charge": shippingCharge,
    "coupon_discount": couponDiscount,
    "coupon_code": couponCode,
    "total_amount": totalAmount,
    "total_rewards": totalRewards,
    "total_kg": totalKg,
    "total_items": totalItems,
    "socity_id": socityId,
    "address_id": addressId,
    "delivery_address": deliveryAddress,
    "area": area,
    "location_id": locationId,
    "delivery_charge": deliveryCharge,
    "new_store_id": newStoreId,
    "assign_to": assignTo,
    "payment_method": paymentMethod,
    "First_name": firstName,
    "Last_name": lastName,
    "email": email,
    "phone_no": phoneNo,
    "zip_code": zipCode,
    "date_time": dateTime,
    "deliveryboy_order_status": deliveryboyOrderStatus,
    "assigned_time": assignedTime,
    "is_status": isStatus,
    "delivery_latitude": deliveryLatitude,
    "delivery_longitude": deliveryLongitude,
    "order_received_time": orderReceivedTime,
    "food_prepare_time": foodPrepareTime,
    "order_pickup_time": orderPickupTime,
    "order_delivered_time": orderDeliveredTime,
    "order_time_complete": orderTimeComplete,
    "city": city,
    "distance": distance,
    "reciver_full_address": reciverFullAddress,
    "sender_latitude": senderLatitude,
    "sender_longitude": senderLongitude,
    "receiver_latitude": "${receiverLatitude.year.toString().padLeft(4, '0')}-${receiverLatitude.month.toString().padLeft(2, '0')}-${receiverLatitude.day.toString().padLeft(2, '0')}",
    "receiver_longitude": receiverLongitude,
    "parcel_photo": parcelPhoto,
    "is_cod_order_verify": isCodOrderVerify,
    "account_name": accountName,
    "account_number": accountNumber,
    "parcel_history": parcelHistory,
    "material_info": materialInfo.toJson(),
  };
}

class MaterialInfo {
  MaterialInfo({
    required this.saleItemId,
    required this.saleId,
    required this.productId,
    required this.productName,
    required this.qty,
    required this.unit,
    required this.unitValue,
    required this.price,
    required this.qtyInKg,
    required this.rewards,
    required this.discountprice,
    required this.meterialCategory,
    required this.parcelWeight,
  });

  String saleItemId;
  String saleId;
  String productId;
  String productName;
  String qty;
  String unit;
  String unitValue;
  String price;
  String qtyInKg;
  String rewards;
  String discountprice;
  String meterialCategory;
  String parcelWeight;

  factory MaterialInfo.fromJson(Map<String, dynamic> json) => MaterialInfo(
    saleItemId: json["sale_item_id"],
    saleId: json["sale_id"],
    productId: json["product_id"],
    productName: json["product_name"],
    qty: json["qty"],
    unit: json["unit"],
    unitValue: json["unit_value"],
    price: json["price"],
    qtyInKg: json["qty_in_kg"],
    rewards: json["rewards"],
    discountprice: json["discountprice"],
    meterialCategory: json["meterial_category"],
    parcelWeight: json["parcel_weight"],
  );

  Map<String, dynamic> toJson() => {
    "sale_item_id": saleItemId,
    "sale_id": saleId,
    "product_id": productId,
    "product_name": productName,
    "qty": qty,
    "unit": unit,
    "unit_value": unitValue,
    "price": price,
    "qty_in_kg": qtyInKg,
    "rewards": rewards,
    "discountprice": discountprice,
    "meterial_category": meterialCategory,
    "parcel_weight": parcelWeight,
  };
}
