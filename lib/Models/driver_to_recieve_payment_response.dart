class DriverToReceivePaymentResponse {
  bool? status;
  DriverToReceivePaymentData? data;
  String? message;

  DriverToReceivePaymentResponse({this.status, this.data, this.message});

  DriverToReceivePaymentResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new DriverToReceivePaymentData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class DriverToReceivePaymentData {
  List<OrderData>? orderData;
  int? totalAmount;
  String? accountNumber;

  DriverToReceivePaymentData({this.orderData, this.totalAmount, this.accountNumber});

  DriverToReceivePaymentData.fromJson(Map<String, dynamic> json) {
    if (json['order_data'] != null) {
      orderData = <OrderData>[];
      json['order_data'].forEach((v) {
        orderData!.add(new OrderData.fromJson(v));
      });
    }
    totalAmount = json['total_amount'];
    accountNumber = json['account_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderData != null) {
      data['order_data'] = this.orderData!.map((v) => v.toJson()).toList();
    }
    data['total_amount'] = this.totalAmount;
    data['account_number'] = this.accountNumber;
    return data;
  }
}

class OrderData {
  String? id;
  String? parcelId;
  String? deliveryBoySender;
  String? deliveryBoyReceiver;
  String? lastLatitude;
  String? lastLongitude;
  String? driverAmont;
  String? adminAmount;
  String? distance;
  String? createdAt;
  String? updatedAt;
  String? saleId;
  String? orderId;
  String? barcode;
  String? barcodeLink;
  String? userId;
  String? deliveryBoyId;
  String? bookingRef;
  String? senderName;
  String? senderAddress;
  String? senderFulladdress;
  String? receiverName;
  String? receiverPhone;
  String? receiverAddress;
  String? reqDeliveryboyIds;
  String? onDate;
  String? deliveryTimeFrom;
  String? deliveryTimeTo;
  String? slottime;
  String? status;
  String? note;
  String? isPaid;
  String? shippingCharge;
  String? couponDiscount;
  String? couponCode;
  String? totalAmount;
  String? totalRewards;
  String? totalKg;
  String? totalItems;
  String? socityId;
  String? addressId;
  String? deliveryAddress;
  String? area;
  String? locationId;
  String? deliveryCharge;
  String? newStoreId;
  String? assignTo;
  String? paymentMethod;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNo;
  String? zipCode;
  String? dateTime;
  String? deliveryboyOrderStatus;
  String? assignedTime;
  String? isStatus;
  String? deliveryLatitude;
  String? deliveryLongitude;
  String? orderReceivedTime;
  String? foodPrepareTime;
  String? orderPickupTime;
  String? orderDeliveredTime;
  String? orderTimeComplete;
  String? city;
  String? reciverFullAddress;
  String? senderLatitude;
  String? senderLongitude;
  String? receiverLatitude;
  String? receiverLongitude;
  String? parcelPhoto;
  String? isCodOrderVerify;
  String? accountName;
  String? accountNumber;
  String? parcelHistory;
  String? otp;
  String? phDistance;
  String? driverPayStatus;

  OrderData(
      {this.id,
        this.parcelId,
        this.deliveryBoySender,
        this.deliveryBoyReceiver,
        this.lastLatitude,
        this.lastLongitude,
        this.driverAmont,
        this.adminAmount,
        this.distance,
        this.createdAt,
        this.updatedAt,
        this.saleId,
        this.orderId,
        this.barcode,
        this.barcodeLink,
        this.userId,
        this.deliveryBoyId,
        this.bookingRef,
        this.senderName,
        this.senderAddress,
        this.senderFulladdress,
        this.receiverName,
        this.receiverPhone,
        this.receiverAddress,
        this.reqDeliveryboyIds,
        this.onDate,
        this.deliveryTimeFrom,
        this.deliveryTimeTo,
        this.slottime,
        this.status,
        this.note,
        this.isPaid,
        this.shippingCharge,
        this.couponDiscount,
        this.couponCode,
        this.totalAmount,
        this.totalRewards,
        this.totalKg,
        this.totalItems,
        this.socityId,
        this.addressId,
        this.deliveryAddress,
        this.area,
        this.locationId,
        this.deliveryCharge,
        this.newStoreId,
        this.assignTo,
        this.paymentMethod,
        this.firstName,
        this.lastName,
        this.email,
        this.phoneNo,
        this.zipCode,
        this.dateTime,
        this.deliveryboyOrderStatus,
        this.assignedTime,
        this.isStatus,
        this.deliveryLatitude,
        this.deliveryLongitude,
        this.orderReceivedTime,
        this.foodPrepareTime,
        this.orderPickupTime,
        this.orderDeliveredTime,
        this.orderTimeComplete,
        this.city,
        this.reciverFullAddress,
        this.senderLatitude,
        this.senderLongitude,
        this.receiverLatitude,
        this.receiverLongitude,
        this.parcelPhoto,
        this.isCodOrderVerify,
        this.accountName,
        this.accountNumber,
        this.parcelHistory,
        this.otp,
        this.phDistance,
        this.driverPayStatus});

  OrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parcelId = json['parcel_id'];
    deliveryBoySender = json['delivery_boy_sender'];
    deliveryBoyReceiver = json['delivery_boy_receiver'];
    lastLatitude = json['last_latitude'];
    lastLongitude = json['last_longitude'];
    driverAmont = json['driver_amont'];
    adminAmount = json['admin_amount'];
    distance = json['distance'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    saleId = json['sale_id'];
    orderId = json['order_id'];
    barcode = json['barcode'];
    barcodeLink = json['barcode_link'];
    userId = json['user_id'];
    deliveryBoyId = json['delivery_boy_id'];
    bookingRef = json['booking_ref'];
    senderName = json['sender_name'];
    senderAddress = json['sender_address'];
    senderFulladdress = json['sender_fulladdress'];
    receiverName = json['receiver_name'];
    receiverPhone = json['receiver_phone'];
    receiverAddress = json['receiver_address'];
    reqDeliveryboyIds = json['req_deliveryboy_ids'];
    onDate = json['on_date'];
    deliveryTimeFrom = json['delivery_time_from'];
    deliveryTimeTo = json['delivery_time_to'];
    slottime = json['slottime'];
    status = json['status'];
    note = json['note'];
    isPaid = json['is_paid'];
    shippingCharge = json['shipping_charge'];
    couponDiscount = json['coupon_discount'];
    couponCode = json['coupon_code'];
    totalAmount = json['total_amount'];
    totalRewards = json['total_rewards'];
    totalKg = json['total_kg'];
    totalItems = json['total_items'];
    socityId = json['socity_id'];
    addressId = json['address_id'];
    deliveryAddress = json['delivery_address'];
    area = json['area'];
    locationId = json['location_id'];
    deliveryCharge = json['delivery_charge'];
    newStoreId = json['new_store_id'];
    assignTo = json['assign_to'];
    paymentMethod = json['payment_method'];
    firstName = json['First_name'];
    lastName = json['Last_name'];
    email = json['email'];
    phoneNo = json['phone_no'];
    zipCode = json['zip_code'];
    dateTime = json['date_time'];
    deliveryboyOrderStatus = json['deliveryboy_order_status'];
    assignedTime = json['assigned_time'];
    isStatus = json['is_status'];
    deliveryLatitude = json['delivery_latitude'];
    deliveryLongitude = json['delivery_longitude'];
    orderReceivedTime = json['order_received_time'];
    foodPrepareTime = json['food_prepare_time'];
    orderPickupTime = json['order_pickup_time'];
    orderDeliveredTime = json['order_delivered_time'];
    orderTimeComplete = json['order_time_complete'];
    city = json['city'];
    reciverFullAddress = json['reciver_full_address'];
    senderLatitude = json['sender_latitude'];
    senderLongitude = json['sender_longitude'];
    receiverLatitude = json['receiver_latitude'];
    receiverLongitude = json['receiver_longitude'];
    parcelPhoto = json['parcel_photo'];
    isCodOrderVerify = json['is_cod_order_verify'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    parcelHistory = json['parcel_history'];
    otp = json['otp'];
    phDistance = json['ph_distance'];
    driverPayStatus = json['driver_pay_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parcel_id'] = this.parcelId;
    data['delivery_boy_sender'] = this.deliveryBoySender;
    data['delivery_boy_receiver'] = this.deliveryBoyReceiver;
    data['last_latitude'] = this.lastLatitude;
    data['last_longitude'] = this.lastLongitude;
    data['driver_amont'] = this.driverAmont;
    data['admin_amount'] = this.adminAmount;
    data['distance'] = this.distance;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['sale_id'] = this.saleId;
    data['order_id'] = this.orderId;
    data['barcode'] = this.barcode;
    data['barcode_link'] = this.barcodeLink;
    data['user_id'] = this.userId;
    data['delivery_boy_id'] = this.deliveryBoyId;
    data['booking_ref'] = this.bookingRef;
    data['sender_name'] = this.senderName;
    data['sender_address'] = this.senderAddress;
    data['sender_fulladdress'] = this.senderFulladdress;
    data['receiver_name'] = this.receiverName;
    data['receiver_phone'] = this.receiverPhone;
    data['receiver_address'] = this.receiverAddress;
    data['req_deliveryboy_ids'] = this.reqDeliveryboyIds;
    data['on_date'] = this.onDate;
    data['delivery_time_from'] = this.deliveryTimeFrom;
    data['delivery_time_to'] = this.deliveryTimeTo;
    data['slottime'] = this.slottime;
    data['status'] = this.status;
    data['note'] = this.note;
    data['is_paid'] = this.isPaid;
    data['shipping_charge'] = this.shippingCharge;
    data['coupon_discount'] = this.couponDiscount;
    data['coupon_code'] = this.couponCode;
    data['total_amount'] = this.totalAmount;
    data['total_rewards'] = this.totalRewards;
    data['total_kg'] = this.totalKg;
    data['total_items'] = this.totalItems;
    data['socity_id'] = this.socityId;
    data['address_id'] = this.addressId;
    data['delivery_address'] = this.deliveryAddress;
    data['area'] = this.area;
    data['location_id'] = this.locationId;
    data['delivery_charge'] = this.deliveryCharge;
    data['new_store_id'] = this.newStoreId;
    data['assign_to'] = this.assignTo;
    data['payment_method'] = this.paymentMethod;
    data['First_name'] = this.firstName;
    data['Last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone_no'] = this.phoneNo;
    data['zip_code'] = this.zipCode;
    data['date_time'] = this.dateTime;
    data['deliveryboy_order_status'] = this.deliveryboyOrderStatus;
    data['assigned_time'] = this.assignedTime;
    data['is_status'] = this.isStatus;
    data['delivery_latitude'] = this.deliveryLatitude;
    data['delivery_longitude'] = this.deliveryLongitude;
    data['order_received_time'] = this.orderReceivedTime;
    data['food_prepare_time'] = this.foodPrepareTime;
    data['order_pickup_time'] = this.orderPickupTime;
    data['order_delivered_time'] = this.orderDeliveredTime;
    data['order_time_complete'] = this.orderTimeComplete;
    data['city'] = this.city;
    data['reciver_full_address'] = this.reciverFullAddress;
    data['sender_latitude'] = this.senderLatitude;
    data['sender_longitude'] = this.senderLongitude;
    data['receiver_latitude'] = this.receiverLatitude;
    data['receiver_longitude'] = this.receiverLongitude;
    data['parcel_photo'] = this.parcelPhoto;
    data['is_cod_order_verify'] = this.isCodOrderVerify;
    data['account_name'] = this.accountName;
    data['account_number'] = this.accountNumber;
    data['parcel_history'] = this.parcelHistory;
    data['otp'] = this.otp;
    data['ph_distance'] = this.phDistance;
    data['driver_pay_status'] = this.driverPayStatus;
    return data;
  }
}
