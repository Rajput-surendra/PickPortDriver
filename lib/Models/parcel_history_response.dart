// To parse this JSON data, do
//
//     final parcelHistoryResponse = parcelHistoryResponseFromJson(jsonString);

import 'dart:convert';

ParcelHistoryResponse parcelHistoryResponseFromJson(String str) => ParcelHistoryResponse.fromJson(json.decode(str));

String parcelHistoryResponseToJson(ParcelHistoryResponse data) => json.encode(data.toJson());

class ParcelHistoryResponse {
  ParcelHistoryResponse({
    required this.status,
    required this.message,
    this.data,
  });

  int status;
  String message;
  List<ParcelHistoryDataList>? data;

  factory ParcelHistoryResponse.fromJson(Map<String, dynamic> json) => ParcelHistoryResponse(
    status: json["status"],
    message: json["message"],
    data: List<ParcelHistoryDataList>.from(json["data"].map((x) => ParcelHistoryDataList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ParcelHistoryDataList {
  ParcelHistoryDataList({
    required this.id,
    required this.parcelId,
    required this.deliveryBoySender,
    required this.deliveryBoyReceiver,
    required this.lastLatitude,
    required this.lastLongitude,
    required this.driverAmont,
    required this.adminAmount,
    required this.distance,
    required this.createdAt,
    required this.updatedAt,
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
    required this.phDistance,
    required this.receiverInfo,
  });

  String id;
  String parcelId;
  String deliveryBoySender;
  String deliveryBoyReceiver;
  String lastLatitude;
  String lastLongitude;
  String driverAmont;
  String adminAmount;
  String distance;
  String createdAt;
  String updatedAt;
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
  String onDate;
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
  String reciverFullAddress;
  String senderLatitude;
  String senderLongitude;
  String receiverLatitude;
  String receiverLongitude;
  String parcelPhoto;
  String isCodOrderVerify;
  String accountName;
  String accountNumber;
  String parcelHistory;
  String phDistance;
  ReceiverInfo receiverInfo;

  factory ParcelHistoryDataList.fromJson(Map<String, dynamic> json) => ParcelHistoryDataList(
    id: json["id"],
    parcelId: json["parcel_id"],
    deliveryBoySender: json["delivery_boy_sender"],
    deliveryBoyReceiver: json["delivery_boy_receiver"],
    lastLatitude: json["last_latitude"],
    lastLongitude: json["last_longitude"],
    driverAmont: json["driver_amont"],
    adminAmount: json["admin_amount"],
    distance: json["distance"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
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
    onDate: json["on_date"],
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
    reciverFullAddress: json["reciver_full_address"],
    senderLatitude: json["sender_latitude"],
    senderLongitude: json["sender_longitude"],
    receiverLatitude: json["receiver_latitude"],
    receiverLongitude: json["receiver_longitude"],
    parcelPhoto: json["parcel_photo"],
    isCodOrderVerify: json["is_cod_order_verify"],
    accountName: json["account_name"],
    accountNumber: json["account_number"],
    parcelHistory: json["parcel_history"],
    phDistance: json["ph_distance"],
    receiverInfo: ReceiverInfo.fromJson(json["receiver_info"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parcel_id": parcelId,
    "delivery_boy_sender": deliveryBoySender,
    "delivery_boy_receiver": deliveryBoyReceiver,
    "last_latitude": lastLatitude,
    "last_longitude": lastLongitude,
    "driver_amont": driverAmont,
    "admin_amount": adminAmount,
    "distance": distance,
    "created_at": createdAt,
    "updated_at": updatedAt,
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
    "on_date": onDate,
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
    "reciver_full_address": reciverFullAddress,
    "sender_latitude": senderLatitude,
    "sender_longitude": senderLongitude,
    "receiver_latitude": receiverLatitude,
    "receiver_longitude": receiverLongitude,
    "parcel_photo": parcelPhoto,
    "is_cod_order_verify": isCodOrderVerify,
    "account_name": accountName,
    "account_number": accountNumber,
    "parcel_history": parcelHistory,
    "ph_distance": phDistance,
    "receiver_info": receiverInfo.toJson(),
  };
}

class ReceiverInfo {
  ReceiverInfo({
    this.userId,
    this.userType,
    this.userPhone,
    this.firstname,
    this.lastname,
    this.userFullname,
    this.userEmail,
    this.userBdate,
    this.userPassword,
    this.userCity,
    this.varificationCode,
    this.userImage,
    this.pincode,
    this.socityId,
    this.houseNo,
    this.mobileVerified,
    this.userGcmCode,
    this.userIosToken,
    this.varifiedToken,
    this.status,
    this.regCode,
    this.wallet,
    this.rewards,
    this.created,
    this.modified,
    this.otp,
    this.otpStatus,
    this.social,
    this.facebookId,
    this.isEmailVerified,
    this.vehicleType,
    this.vehicleNo,
    this.drivingLicenceNo,
    this.drivingLicencePhoto,
    this.loginStatus,
    this.isAvaible,
    this.latitude,
    this.longitude,
    this.referralCode,
    this.aadhaarCardNo,
    this.aadhaarCardPhoto,
    this.qrCode,
    this.accountHolderName,
    this.accountNumber,
    this.ifscCode,
    this.bankName,
  });

  String? userId;
  String? userType;
  String? userPhone;
  String? firstname;
  String? lastname;
  String? userFullname;
  String? userEmail;
  String? userBdate;
  String? userPassword;
  String? userCity;
  String? varificationCode;
  String? userImage;
  String? pincode;
  String? socityId;
  String? houseNo;
  String? mobileVerified;
  String? userGcmCode;
  String? userIosToken;
  String? varifiedToken;
  String? status;
  String? regCode;
  String? wallet;
  String? rewards;
  DateTime? created;
  DateTime? modified;
  String? otp;
  String? otpStatus;
  String? social;
  String? facebookId;
  String? isEmailVerified;
  String? vehicleType;
  String? vehicleNo;
  String? drivingLicenceNo;
  String? drivingLicencePhoto;
  String? loginStatus;
  String? isAvaible;
  String? latitude;
  String? longitude;
  String? referralCode;
  String? aadhaarCardNo;
  String? aadhaarCardPhoto;
  String? qrCode;
  String? accountHolderName;
  String? accountNumber;
  String? ifscCode;
  String? bankName;

  factory ReceiverInfo.fromJson(Map<String, dynamic> json) => ReceiverInfo(
    userId: json["user_id"],
    userType: json["user_type"],
    userPhone: json["user_phone"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    userFullname: json["user_fullname"],
    userEmail: json["user_email"],
    userBdate: json["user_bdate"],
    userPassword: json["user_password"],
    userCity: json["user_city"],
    varificationCode: json["varification_code"],
    userImage: json["user_image"],
    pincode: json["pincode"],
    socityId: json["socity_id"],
    houseNo: json["house_no"],
    mobileVerified: json["mobile_verified"],
    userGcmCode: json["user_gcm_code"],
    userIosToken: json["user_ios_token"],
    varifiedToken: json["varified_token"],
    status: json["status"],
    regCode: json["reg_code"],
    wallet: json["wallet"],
    rewards: json["rewards"],
    created: json["created"] == null ? null : DateTime.parse(json["created"]),
    modified: json["modified"] == null ? null : DateTime.parse(json["modified"]),
    otp: json["otp"],
    otpStatus: json["otp_status"],
    social: json["social"],
    facebookId: json["facebookID"],
    isEmailVerified: json["is_email_verified"],
    vehicleType: json["vehicle_type"],
    vehicleNo: json["vehicle_no"],
    drivingLicenceNo: json["driving_licence_no"],
    drivingLicencePhoto: json["driving_licence_photo"],
    loginStatus: json["login_status"],
    isAvaible: json["is_avaible"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    referralCode: json["referral_code"],
    aadhaarCardNo: json["aadhaar_card_no"],
    aadhaarCardPhoto: json["aadhaar_card_photo"],
    qrCode: json["qr_code"],
    accountHolderName: json["account_holder_name"],
    accountNumber: json["account_number"],
    ifscCode: json["ifsc_code"],
    bankName: json["bank_name"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user_type": userType,
    "user_phone": userPhone,
    "firstname": firstname,
    "lastname": lastname,
    "user_fullname": userFullname,
    "user_email": userEmail,
    "user_bdate": userBdate,
    "user_password": userPassword,
    "user_city": userCity,
    "varification_code": varificationCode,
    "user_image": userImage,
    "pincode": pincode,
    "socity_id": socityId,
    "house_no": houseNo,
    "mobile_verified": mobileVerified,
    "user_gcm_code": userGcmCode,
    "user_ios_token": userIosToken,
    "varified_token": varifiedToken,
    "status": status,
    "reg_code": regCode,
    "wallet": wallet,
    "rewards": rewards,
    "created": created?.toIso8601String(),
    "modified": modified?.toIso8601String(),
    "otp": otp,
    "otp_status": otpStatus,
    "social": social,
    "facebookID": facebookId,
    "is_email_verified": isEmailVerified,
    "vehicle_type": vehicleType,
    "vehicle_no": vehicleNo,
    "driving_licence_no": drivingLicenceNo,
    "driving_licence_photo": drivingLicencePhoto,
    "login_status": loginStatus,
    "is_avaible": isAvaible,
    "latitude": latitude,
    "longitude": longitude,
    "referral_code": referralCode,
    "aadhaar_card_no": aadhaarCardNo,
    "aadhaar_card_photo": aadhaarCardPhoto,
    "qr_code": qrCode,
    "account_holder_name": accountHolderName,
    "account_number": accountNumber,
    "ifsc_code": ifscCode,
    "bank_name": bankName,
  };
}
