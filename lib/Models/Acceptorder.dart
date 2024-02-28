/// status : 1
/// error_code : 200
/// error_line : 1530
/// message : "Record found"
/// data : [{"order_id":"1","user_id":"210","sender_name":"test","sender_address":"test","sender_fulladdress":"45","order_amount":"120","payment_method":"","phone_no":"848489","is_paid":"0","sender_latitude":"454","sender_longitude":"54","on_date":"2023-03-16 12:29:28","delivery_time_from":"2023-03-16 05:59","sale_ids":"1,2,3","parcel_details":[{"sale_id":"1","order_id":"1","barcode":"1678969768","barcode_link":"./uploads/qr_code/64130ba8043ea.jpeg","user_id":"210","delivery_boy_id":"300","booking_ref":"16789697681","sender_name":"test","sender_address":"test","sender_fulladdress":"45","receiver_name":"1","receiver_phone":"2","receiver_address":"product1","req_deliveryboy_ids":"","on_date":"2023-03-16","delivery_time_from":"05:59:28pm","delivery_time_to":"","slottime":"","status":"2","note":"","is_paid":"0","shipping_charge":"0","coupon_discount":"0","coupon_code":"","total_amount":"40","total_rewards":"","total_kg":"0","total_items":"0","socity_id":"0","address_id":"0","delivery_address":"","area":"","location_id":"0","delivery_charge":"0","new_store_id":"0","assign_to":"0","payment_method":"","First_name":"","Last_name":"","email":"","phone_no":"848489","zip_code":"0","date_time":"2023-03-16 05:59","deliveryboy_order_status":"0","assigned_time":"","is_status":"2","delivery_latitude":"","delivery_longitude":"","order_received_time":"2023-03-16 18:17:10","food_prepare_time":"","order_pickup_time":"","order_delivered_time":"","order_time_complete":"","city":"0","distance":"14472.22","reciver_full_address":"1","sender_latitude":"454","sender_longitude":"54","receiver_latitude":"2023-02-12","receiver_longitude":"100","parcel_photo":"","is_cod_order_verify":"0","account_name":"","account_number":"","parcel_history":"2","material_info":{"sale_item_id":"1","sale_id":"1","product_id":"0","product_name":"","qty":"0","unit":"","unit_value":"0","price":"40","qty_in_kg":"0","rewards":"","discountprice":"0","meterial_category":"15","parcel_weight":"up to 20 kg"}},{"sale_id":"2","order_id":"1","barcode":"1678969768","barcode_link":"./uploads/qr_code/64130ba8043ea.jpeg","user_id":"210","delivery_boy_id":"300","booking_ref":"16789697682","sender_name":"test","sender_address":"test","sender_fulladdress":"45","receiver_name":"1","receiver_phone":"2","receiver_address":"product1","req_deliveryboy_ids":"","on_date":"2023-03-16","delivery_time_from":"05:59:28pm","delivery_time_to":"","slottime":"","status":"1","note":"","is_paid":"0","shipping_charge":"0","coupon_discount":"0","coupon_code":"","total_amount":"40","total_rewards":"","total_kg":"0","total_items":"0","socity_id":"0","address_id":"0","delivery_address":"","area":"","location_id":"0","delivery_charge":"0","new_store_id":"0","assign_to":"0","payment_method":"","First_name":"","Last_name":"","email":"","phone_no":"848489","zip_code":"0","date_time":"2023-03-16 05:59","deliveryboy_order_status":"0","assigned_time":"","is_status":"0","delivery_latitude":"","delivery_longitude":"","order_received_time":"","food_prepare_time":"","order_pickup_time":"","order_delivered_time":"","order_time_complete":"","city":"0","distance":"14472.22","reciver_full_address":"1","sender_latitude":"454","sender_longitude":"54","receiver_latitude":"2023-02-12","receiver_longitude":"100","parcel_photo":"","is_cod_order_verify":"0","account_name":"","account_number":"","parcel_history":"0","material_info":{"sale_item_id":"2","sale_id":"2","product_id":"0","product_name":"","qty":"0","unit":"","unit_value":"0","price":"40","qty_in_kg":"0","rewards":"","discountprice":"0","meterial_category":"15","parcel_weight":"up to 20 kg"}},{"sale_id":"3","order_id":"1","barcode":"1678969768","barcode_link":"./uploads/qr_code/64130ba8043ea.jpeg","user_id":"210","delivery_boy_id":"300","booking_ref":"16789697683","sender_name":"test","sender_address":"test","sender_fulladdress":"45","receiver_name":"1","receiver_phone":"2","receiver_address":"product1","req_deliveryboy_ids":"","on_date":"2023-03-16","delivery_time_from":"05:59:28pm","delivery_time_to":"","slottime":"","status":"1","note":"","is_paid":"0","shipping_charge":"0","coupon_discount":"0","coupon_code":"","total_amount":"40","total_rewards":"","total_kg":"0","total_items":"0","socity_id":"0","address_id":"0","delivery_address":"","area":"","location_id":"0","delivery_charge":"0","new_store_id":"0","assign_to":"0","payment_method":"","First_name":"","Last_name":"","email":"","phone_no":"848489","zip_code":"0","date_time":"2023-03-16 05:59","deliveryboy_order_status":"0","assigned_time":"2023-03-16 17:59:40","is_status":"1","delivery_latitude":"","delivery_longitude":"","order_received_time":"","food_prepare_time":"","order_pickup_time":"","order_delivered_time":"","order_time_complete":"","city":"0","distance":"14472.22","reciver_full_address":"1","sender_latitude":"454","sender_longitude":"54","receiver_latitude":"2023-02-12","receiver_longitude":"100","parcel_photo":"","is_cod_order_verify":"0","account_name":"","account_number":"","parcel_history":"0","material_info":{"sale_item_id":"3","sale_id":"3","product_id":"0","product_name":"","qty":"0","unit":"","unit_value":"0","price":"40","qty_in_kg":"0","rewards":"","discountprice":"0","meterial_category":"15","parcel_weight":"up to 20 kg"}}]}]

class Acceptorder {
  Acceptorder({
      num? status, 
      num? errorCode, 
      num? errorLine, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _errorCode = errorCode;
    _errorLine = errorLine;
    _message = message;
    _data = data;
}

  Acceptorder.fromJson(dynamic json) {
    _status = json['status'];
    _errorCode = json['error_code'];
    _errorLine = json['error_line'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  num? _status;
  num? _errorCode;
  num? _errorLine;
  String? _message;
  List<Data>? _data;
Acceptorder copyWith({  num? status,
  num? errorCode,
  num? errorLine,
  String? message,
  List<Data>? data,
}) => Acceptorder(  status: status ?? _status,
  errorCode: errorCode ?? _errorCode,
  errorLine: errorLine ?? _errorLine,
  message: message ?? _message,
  data: data ?? _data,
);
  num? get status => _status;
  num? get errorCode => _errorCode;
  num? get errorLine => _errorLine;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['error_code'] = _errorCode;
    map['error_line'] = _errorLine;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// order_id : "1"
/// user_id : "210"
/// sender_name : "test"
/// sender_address : "test"
/// sender_fulladdress : "45"
/// order_amount : "120"
/// payment_method : ""
/// phone_no : "848489"
/// is_paid : "0"
/// sender_latitude : "454"
/// sender_longitude : "54"
/// on_date : "2023-03-16 12:29:28"
/// delivery_time_from : "2023-03-16 05:59"
/// sale_ids : "1,2,3"
/// parcel_details : [{"sale_id":"1","order_id":"1","barcode":"1678969768","barcode_link":"./uploads/qr_code/64130ba8043ea.jpeg","user_id":"210","delivery_boy_id":"300","booking_ref":"16789697681","sender_name":"test","sender_address":"test","sender_fulladdress":"45","receiver_name":"1","receiver_phone":"2","receiver_address":"product1","req_deliveryboy_ids":"","on_date":"2023-03-16","delivery_time_from":"05:59:28pm","delivery_time_to":"","slottime":"","status":"2","note":"","is_paid":"0","shipping_charge":"0","coupon_discount":"0","coupon_code":"","total_amount":"40","total_rewards":"","total_kg":"0","total_items":"0","socity_id":"0","address_id":"0","delivery_address":"","area":"","location_id":"0","delivery_charge":"0","new_store_id":"0","assign_to":"0","payment_method":"","First_name":"","Last_name":"","email":"","phone_no":"848489","zip_code":"0","date_time":"2023-03-16 05:59","deliveryboy_order_status":"0","assigned_time":"","is_status":"2","delivery_latitude":"","delivery_longitude":"","order_received_time":"2023-03-16 18:17:10","food_prepare_time":"","order_pickup_time":"","order_delivered_time":"","order_time_complete":"","city":"0","distance":"14472.22","reciver_full_address":"1","sender_latitude":"454","sender_longitude":"54","receiver_latitude":"2023-02-12","receiver_longitude":"100","parcel_photo":"","is_cod_order_verify":"0","account_name":"","account_number":"","parcel_history":"2","material_info":{"sale_item_id":"1","sale_id":"1","product_id":"0","product_name":"","qty":"0","unit":"","unit_value":"0","price":"40","qty_in_kg":"0","rewards":"","discountprice":"0","meterial_category":"15","parcel_weight":"up to 20 kg"}},{"sale_id":"2","order_id":"1","barcode":"1678969768","barcode_link":"./uploads/qr_code/64130ba8043ea.jpeg","user_id":"210","delivery_boy_id":"300","booking_ref":"16789697682","sender_name":"test","sender_address":"test","sender_fulladdress":"45","receiver_name":"1","receiver_phone":"2","receiver_address":"product1","req_deliveryboy_ids":"","on_date":"2023-03-16","delivery_time_from":"05:59:28pm","delivery_time_to":"","slottime":"","status":"1","note":"","is_paid":"0","shipping_charge":"0","coupon_discount":"0","coupon_code":"","total_amount":"40","total_rewards":"","total_kg":"0","total_items":"0","socity_id":"0","address_id":"0","delivery_address":"","area":"","location_id":"0","delivery_charge":"0","new_store_id":"0","assign_to":"0","payment_method":"","First_name":"","Last_name":"","email":"","phone_no":"848489","zip_code":"0","date_time":"2023-03-16 05:59","deliveryboy_order_status":"0","assigned_time":"","is_status":"0","delivery_latitude":"","delivery_longitude":"","order_received_time":"","food_prepare_time":"","order_pickup_time":"","order_delivered_time":"","order_time_complete":"","city":"0","distance":"14472.22","reciver_full_address":"1","sender_latitude":"454","sender_longitude":"54","receiver_latitude":"2023-02-12","receiver_longitude":"100","parcel_photo":"","is_cod_order_verify":"0","account_name":"","account_number":"","parcel_history":"0","material_info":{"sale_item_id":"2","sale_id":"2","product_id":"0","product_name":"","qty":"0","unit":"","unit_value":"0","price":"40","qty_in_kg":"0","rewards":"","discountprice":"0","meterial_category":"15","parcel_weight":"up to 20 kg"}},{"sale_id":"3","order_id":"1","barcode":"1678969768","barcode_link":"./uploads/qr_code/64130ba8043ea.jpeg","user_id":"210","delivery_boy_id":"300","booking_ref":"16789697683","sender_name":"test","sender_address":"test","sender_fulladdress":"45","receiver_name":"1","receiver_phone":"2","receiver_address":"product1","req_deliveryboy_ids":"","on_date":"2023-03-16","delivery_time_from":"05:59:28pm","delivery_time_to":"","slottime":"","status":"1","note":"","is_paid":"0","shipping_charge":"0","coupon_discount":"0","coupon_code":"","total_amount":"40","total_rewards":"","total_kg":"0","total_items":"0","socity_id":"0","address_id":"0","delivery_address":"","area":"","location_id":"0","delivery_charge":"0","new_store_id":"0","assign_to":"0","payment_method":"","First_name":"","Last_name":"","email":"","phone_no":"848489","zip_code":"0","date_time":"2023-03-16 05:59","deliveryboy_order_status":"0","assigned_time":"2023-03-16 17:59:40","is_status":"1","delivery_latitude":"","delivery_longitude":"","order_received_time":"","food_prepare_time":"","order_pickup_time":"","order_delivered_time":"","order_time_complete":"","city":"0","distance":"14472.22","reciver_full_address":"1","sender_latitude":"454","sender_longitude":"54","receiver_latitude":"2023-02-12","receiver_longitude":"100","parcel_photo":"","is_cod_order_verify":"0","account_name":"","account_number":"","parcel_history":"0","material_info":{"sale_item_id":"3","sale_id":"3","product_id":"0","product_name":"","qty":"0","unit":"","unit_value":"0","price":"40","qty_in_kg":"0","rewards":"","discountprice":"0","meterial_category":"15","parcel_weight":"up to 20 kg"}}]

class Data {
  Data({
      String? orderId, 
      String? userId, 
      String? senderName, 
      String? senderAddress, 
      String? senderFulladdress, 
      String? orderAmount, 
      String? paymentMethod, 
      String? phoneNo, 
      String? isPaid, 
      String? senderLatitude, 
      String? senderLongitude, 
      String? onDate, 
      String? deliveryTimeFrom, 
      String? saleIds, 
      List<ParcelDetails>? parcelDetails,}){
    _orderId = orderId;
    _userId = userId;
    _senderName = senderName;
    _senderAddress = senderAddress;
    _senderFulladdress = senderFulladdress;
    _orderAmount = orderAmount;
    _paymentMethod = paymentMethod;
    _phoneNo = phoneNo;
    _isPaid = isPaid;
    _senderLatitude = senderLatitude;
    _senderLongitude = senderLongitude;
    _onDate = onDate;
    _deliveryTimeFrom = deliveryTimeFrom;
    _saleIds = saleIds;
    _parcelDetails = parcelDetails;
}

  Data.fromJson(dynamic json) {
    _orderId = json['order_id'];
    _userId = json['user_id'];
    _senderName = json['sender_name'];
    _senderAddress = json['sender_address'];
    _senderFulladdress = json['sender_fulladdress'];
    _orderAmount = json['order_amount'];
    _paymentMethod = json['payment_method'];
    _phoneNo = json['phone_no'];
    _isPaid = json['is_paid'];
    _senderLatitude = json['sender_latitude'];
    _senderLongitude = json['sender_longitude'];
    _onDate = json['on_date'];
    _deliveryTimeFrom = json['delivery_time_from'];
    _saleIds = json['sale_ids'];
    if (json['parcel_details'] != null) {
      _parcelDetails = [];
      json['parcel_details'].forEach((v) {
        _parcelDetails?.add(ParcelDetails.fromJson(v));
      });
    }
  }
  String? _orderId;
  String? _userId;
  String? _senderName;
  String? _senderAddress;
  String? _senderFulladdress;
  String? _orderAmount;
  String? _paymentMethod;
  String? _phoneNo;
  String? _isPaid;
  String? _senderLatitude;
  String? _senderLongitude;
  String? _onDate;
  String? _deliveryTimeFrom;
  String? _saleIds;
  List<ParcelDetails>? _parcelDetails;
Data copyWith({  String? orderId,
  String? userId,
  String? senderName,
  String? senderAddress,
  String? senderFulladdress,
  String? orderAmount,
  String? paymentMethod,
  String? phoneNo,
  String? isPaid,
  String? senderLatitude,
  String? senderLongitude,
  String? onDate,
  String? deliveryTimeFrom,
  String? saleIds,
  List<ParcelDetails>? parcelDetails,
}) => Data(  orderId: orderId ?? _orderId,
  userId: userId ?? _userId,
  senderName: senderName ?? _senderName,
  senderAddress: senderAddress ?? _senderAddress,
  senderFulladdress: senderFulladdress ?? _senderFulladdress,
  orderAmount: orderAmount ?? _orderAmount,
  paymentMethod: paymentMethod ?? _paymentMethod,
  phoneNo: phoneNo ?? _phoneNo,
  isPaid: isPaid ?? _isPaid,
  senderLatitude: senderLatitude ?? _senderLatitude,
  senderLongitude: senderLongitude ?? _senderLongitude,
  onDate: onDate ?? _onDate,
  deliveryTimeFrom: deliveryTimeFrom ?? _deliveryTimeFrom,
  saleIds: saleIds ?? _saleIds,
  parcelDetails: parcelDetails ?? _parcelDetails,
);
  String? get orderId => _orderId;
  String? get userId => _userId;
  String? get senderName => _senderName;
  String? get senderAddress => _senderAddress;
  String? get senderFulladdress => _senderFulladdress;
  String? get orderAmount => _orderAmount;
  String? get paymentMethod => _paymentMethod;
  String? get phoneNo => _phoneNo;
  String? get isPaid => _isPaid;
  String? get senderLatitude => _senderLatitude;
  String? get senderLongitude => _senderLongitude;
  String? get onDate => _onDate;
  String? get deliveryTimeFrom => _deliveryTimeFrom;
  String? get saleIds => _saleIds;
  List<ParcelDetails>? get parcelDetails => _parcelDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_id'] = _orderId;
    map['user_id'] = _userId;
    map['sender_name'] = _senderName;
    map['sender_address'] = _senderAddress;
    map['sender_fulladdress'] = _senderFulladdress;
    map['order_amount'] = _orderAmount;
    map['payment_method'] = _paymentMethod;
    map['phone_no'] = _phoneNo;
    map['is_paid'] = _isPaid;
    map['sender_latitude'] = _senderLatitude;
    map['sender_longitude'] = _senderLongitude;
    map['on_date'] = _onDate;
    map['delivery_time_from'] = _deliveryTimeFrom;
    map['sale_ids'] = _saleIds;
    if (_parcelDetails != null) {
      map['parcel_details'] = _parcelDetails?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// sale_id : "1"
/// order_id : "1"
/// barcode : "1678969768"
/// barcode_link : "./uploads/qr_code/64130ba8043ea.jpeg"
/// user_id : "210"
/// delivery_boy_id : "300"
/// booking_ref : "16789697681"
/// sender_name : "test"
/// sender_address : "test"
/// sender_fulladdress : "45"
/// receiver_name : "1"
/// receiver_phone : "2"
/// receiver_address : "product1"
/// req_deliveryboy_ids : ""
/// on_date : "2023-03-16"
/// delivery_time_from : "05:59:28pm"
/// delivery_time_to : ""
/// slottime : ""
/// status : "2"
/// note : ""
/// is_paid : "0"
/// shipping_charge : "0"
/// coupon_discount : "0"
/// coupon_code : ""
/// total_amount : "40"
/// total_rewards : ""
/// total_kg : "0"
/// total_items : "0"
/// socity_id : "0"
/// address_id : "0"
/// delivery_address : ""
/// area : ""
/// location_id : "0"
/// delivery_charge : "0"
/// new_store_id : "0"
/// assign_to : "0"
/// payment_method : ""
/// First_name : ""
/// Last_name : ""
/// email : ""
/// phone_no : "848489"
/// zip_code : "0"
/// date_time : "2023-03-16 05:59"
/// deliveryboy_order_status : "0"
/// assigned_time : ""
/// is_status : "2"
/// delivery_latitude : ""
/// delivery_longitude : ""
/// order_received_time : "2023-03-16 18:17:10"
/// food_prepare_time : ""
/// order_pickup_time : ""
/// order_delivered_time : ""
/// order_time_complete : ""
/// city : "0"
/// distance : "14472.22"
/// reciver_full_address : "1"
/// sender_latitude : "454"
/// sender_longitude : "54"
/// receiver_latitude : "2023-02-12"
/// receiver_longitude : "100"
/// parcel_photo : ""
/// is_cod_order_verify : "0"
/// account_name : ""
/// account_number : ""
/// parcel_history : "2"
/// material_info : {"sale_item_id":"1","sale_id":"1","product_id":"0","product_name":"","qty":"0","unit":"","unit_value":"0","price":"40","qty_in_kg":"0","rewards":"","discountprice":"0","meterial_category":"15","parcel_weight":"up to 20 kg"}

class ParcelDetails {
  ParcelDetails({
      String? saleId, 
      String? orderId,

      String? barcode,
      String? barcodeLink, 
      String? userId, 
      String? deliveryBoyId, 
      String? bookingRef, 
      String? senderName, 
      String? senderAddress, 
      String? senderFulladdress, 
      String? receiverName, 
      String? receiverPhone, 
      String? receiverAddress, 
      String? reqDeliveryboyIds, 
      String? onDate, 
      String? deliveryTimeFrom, 
      String? deliveryTimeTo, 
      String? slottime, 
      String? status, 
      String? note, 
      String? isPaid, 
      String? shippingCharge, 
      String? couponDiscount, 
      String? couponCode, 
      String? totalAmount, 
      String? totalRewards, 
      String? totalKg, 
      String? totalItems, 
      String? socityId, 
      String? addressId, 
      String? deliveryAddress, 
      String? area, 
      String? locationId, 
      String? deliveryCharge, 
      String? newStoreId, 
      String? assignTo, 
      String? paymentMethod, 
      String? firstName, 
      String? lastName, 
      String? email, 
      String? phoneNo, 
      String? zipCode, 
      String? dateTime, 
      String? deliveryboyOrderStatus, 
      String? assignedTime, 
      String? isStatus, 
      String? deliveryLatitude, 
      String? deliveryLongitude, 
      String? orderReceivedTime, 
      String? foodPrepareTime, 
      String? orderPickupTime, 
      String? orderDeliveredTime, 
      String? orderTimeComplete, 
      String? city, 
      String? distance, 
      String? reciverFullAddress, 
      String? senderLatitude, 
      String? senderLongitude, 
      String? receiverLatitude, 
      String? receiverLongitude, 
      String? parcelPhoto, 
      String? isCodOrderVerify, 
      String? accountName, 
      String? accountNumber,
      String? bookingDate,
      String? parcelHistory,
      MaterialInfo? materialInfo,})
  {
    _saleId = saleId;
    _orderId = orderId;
    _barcode = barcode;
    _barcodeLink = barcodeLink;
    _userId = userId;
    _deliveryBoyId = deliveryBoyId;
    _bookingRef = bookingRef;
    _senderName = senderName;
    _senderAddress = senderAddress;
    _senderFulladdress = senderFulladdress;
    _receiverName = receiverName;
    _receiverPhone = receiverPhone;
    _receiverAddress = receiverAddress;
    _reqDeliveryboyIds = reqDeliveryboyIds;
    _onDate = onDate;
    _deliveryTimeFrom = deliveryTimeFrom;
    _deliveryTimeTo = deliveryTimeTo;
    _slottime = slottime;
    _status = status;
    _note = note;
    _isPaid = isPaid;
    _shippingCharge = shippingCharge;
    _couponDiscount = couponDiscount;
    _couponCode = couponCode;
    _totalAmount = totalAmount;
    _totalRewards = totalRewards;
    _totalKg = totalKg;
    _totalItems = totalItems;
    _socityId = socityId;
    _addressId = addressId;
    _deliveryAddress = deliveryAddress;
    _area = area;
    _locationId = locationId;
    _deliveryCharge = deliveryCharge;
    _newStoreId = newStoreId;
    _assignTo = assignTo;
    _paymentMethod = paymentMethod;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _phoneNo = phoneNo;
    _zipCode = zipCode;
    _dateTime = dateTime;
    _deliveryboyOrderStatus = deliveryboyOrderStatus;
    _assignedTime = assignedTime;
    _isStatus = isStatus;
    _deliveryLatitude = deliveryLatitude;
    _deliveryLongitude = deliveryLongitude;
    _orderReceivedTime = orderReceivedTime;
    _foodPrepareTime = foodPrepareTime;
    _orderPickupTime = orderPickupTime;
    _orderDeliveredTime = orderDeliveredTime;
    _orderTimeComplete = orderTimeComplete;
    _city = city;
    _distance = distance;
    _reciverFullAddress = reciverFullAddress;
    _senderLatitude = senderLatitude;
    _senderLongitude = senderLongitude;
    _receiverLatitude = receiverLatitude;
    _receiverLongitude = receiverLongitude;
    _parcelPhoto = parcelPhoto;
    _isCodOrderVerify = isCodOrderVerify;
    _accountName = accountName;
    _accountNumber = accountNumber;
    _parcelHistory = parcelHistory;
    _materialInfo = materialInfo;
    _bookingDate = bookingDate;
}

  ParcelDetails.fromJson(dynamic json) {
    _saleId = json['sale_id'];
    _orderId = json['order_id'];
    _barcode = json['barcode'];

    _barcodeLink = json['barcode_link'];
    _userId = json['user_id'];
    _deliveryBoyId = json['delivery_boy_id'];
    _bookingRef = json['booking_ref'];
    _senderName = json['sender_name'];
    _senderAddress = json['sender_address'];
    _senderFulladdress = json['sender_fulladdress'];
    _receiverName = json['receiver_name'];
    _bookingDate = json['booking_date'];
    _receiverPhone = json['receiver_phone'];
    _receiverAddress = json['receiver_address'];
    _reqDeliveryboyIds = json['req_deliveryboy_ids'];
    _onDate = json['on_date'];
    _deliveryTimeFrom = json['delivery_time_from'];
    _deliveryTimeTo = json['delivery_time_to'];
    _slottime = json['slottime'];
    _status = json['status'];
    _note = json['note'];
    _isPaid = json['is_paid'];
    _shippingCharge = json['shipping_charge'];
    _couponDiscount = json['coupon_discount'];
    _couponCode = json['coupon_code'];
    _totalAmount = json['total_amount'];
    _totalRewards = json['total_rewards'];
    _totalKg = json['total_kg'];
    _totalItems = json['total_items'];
    _socityId = json['socity_id'];
    _addressId = json['address_id'];
    _deliveryAddress = json['delivery_address'];
    _area = json['area'];
    _locationId = json['location_id'];
    _deliveryCharge = json['delivery_charge'];
    _newStoreId = json['new_store_id'];
    _assignTo = json['assign_to'];
    _paymentMethod = json['payment_method'];
    _firstName = json['First_name'];
    _lastName = json['Last_name'];
    _email = json['email'];
    _phoneNo = json['phone_no'];
    _zipCode = json['zip_code'];
    _dateTime = json['date_time'];
    _deliveryboyOrderStatus = json['deliveryboy_order_status'];
    _assignedTime = json['assigned_time'];
    _isStatus = json['is_status'];
    _deliveryLatitude = json['delivery_latitude'];
    _deliveryLongitude = json['delivery_longitude'];
    _orderReceivedTime = json['order_received_time'];
    _foodPrepareTime = json['food_prepare_time'];
    _orderPickupTime = json['order_pickup_time'];
    _orderDeliveredTime = json['order_delivered_time'];
    _orderTimeComplete = json['order_time_complete'];
    _city = json['city'];
    _distance = json['distance'];
    _reciverFullAddress = json['reciver_full_address'];
    _senderLatitude = json['sender_latitude'];
    _senderLongitude = json['sender_longitude'];
    _receiverLatitude = json['receiver_latitude'];
    _receiverLongitude = json['receiver_longitude'];
    _parcelPhoto = json['parcel_photo'];
    _isCodOrderVerify = json['is_cod_order_verify'];
    _accountName = json['account_name'];
    _accountNumber = json['account_number'];
    _parcelHistory = json['parcel_history'];
    _materialInfo = json['material_info'] != null ? MaterialInfo.fromJson(json['material_info']) : null;
  }
  String? _saleId;
  String? _orderId;
  String? _barcode;
  String? _barcodeLink;
  String? _userId;
  String? _deliveryBoyId;
  String? _bookingRef;
  String? _senderName;
  String? _senderAddress;
  String? _senderFulladdress;
  String? _receiverName;
  String? _bookingDate;
  String? _receiverPhone;
  String? _receiverAddress;
  String? _reqDeliveryboyIds;
  String? _onDate;
  String? _deliveryTimeFrom;
  String? _deliveryTimeTo;
  String? _slottime;
  String? _status;
  String? _note;
  String? _isPaid;
  String? _shippingCharge;
  String? _couponDiscount;
  String? _couponCode;
  String? _totalAmount;
  String? _totalRewards;
  String? _totalKg;
  String? _totalItems;
  String? _socityId;
  String? _addressId;
  String? _deliveryAddress;
  String? _area;
  String? _locationId;
  String? _deliveryCharge;
  String? _newStoreId;
  String? _assignTo;
  String? _paymentMethod;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phoneNo;
  String? _zipCode;
  String? _dateTime;
  String? _deliveryboyOrderStatus;
  String? _assignedTime;
  String? _isStatus;
  String? _deliveryLatitude;
  String? _deliveryLongitude;
  String? _orderReceivedTime;
  String? _foodPrepareTime;
  String? _orderPickupTime;
  String? _orderDeliveredTime;
  String? _orderTimeComplete;
  String? _city;
  String? _distance;
  String? _reciverFullAddress;
  String? _senderLatitude;
  String? _senderLongitude;
  String? _receiverLatitude;
  String? _receiverLongitude;
  String? _parcelPhoto;
  String? _isCodOrderVerify;
  String? _accountName;
  String? _accountNumber;
  String? _parcelHistory;

  MaterialInfo? _materialInfo;
ParcelDetails copyWith({  String? saleId,
  String? orderId,
  String? barcode,
  String? barcodeLink,
  String? userId,
  String? deliveryBoyId,
  String? bookingRef,
  String? senderName,
  String? senderAddress,
  String? senderFulladdress,
  String? receiverName,
  String? bookingDate,
  String? receiverPhone,
  String? receiverAddress,
  String? reqDeliveryboyIds,
  String? onDate,
  String? deliveryTimeFrom,
  String? deliveryTimeTo,
  String? slottime,
  String? status,
  String? note,
  String? isPaid,
  String? shippingCharge,
  String? couponDiscount,
  String? couponCode,
  String? totalAmount,
  String? totalRewards,
  String? totalKg,
  String? totalItems,
  String? socityId,
  String? addressId,
  String? deliveryAddress,
  String? area,
  String? locationId,
  String? deliveryCharge,
  String? newStoreId,
  String? assignTo,
  String? paymentMethod,
  String? firstName,
  String? lastName,
  String? email,
  String? phoneNo,
  String? zipCode,
  String? dateTime,
  String? deliveryboyOrderStatus,
  String? assignedTime,
  String? isStatus,
  String? deliveryLatitude,
  String? deliveryLongitude,
  String? orderReceivedTime,
  String? foodPrepareTime,
  String? orderPickupTime,
  String? orderDeliveredTime,
  String? orderTimeComplete,
  String? city,
  String? distance,
  String? reciverFullAddress,
  String? senderLatitude,
  String? senderLongitude,
  String? receiverLatitude,
  String? receiverLongitude,
  String? parcelPhoto,
  String? isCodOrderVerify,
  String? accountName,
  String? accountNumber,
  String? parcelHistory,

  MaterialInfo? materialInfo,
}) => ParcelDetails(  saleId: saleId ?? _saleId,
  orderId: orderId ?? _orderId,
  barcode: barcode ?? _barcode,
  barcodeLink: barcodeLink ?? _barcodeLink,
  userId: userId ?? _userId,
  deliveryBoyId: deliveryBoyId ?? _deliveryBoyId,
  bookingRef: bookingRef ?? _bookingRef,
  senderName: senderName ?? _senderName,
  senderAddress: senderAddress ?? _senderAddress,
  senderFulladdress: senderFulladdress ?? _senderFulladdress,
  receiverName: receiverName ?? _receiverName,
  bookingDate: bookingDate ?? _bookingDate,
  receiverPhone: receiverPhone ?? _receiverPhone,
  receiverAddress: receiverAddress ?? _receiverAddress,
  reqDeliveryboyIds: reqDeliveryboyIds ?? _reqDeliveryboyIds,
  onDate: onDate ?? _onDate,
  deliveryTimeFrom: deliveryTimeFrom ?? _deliveryTimeFrom,
  deliveryTimeTo: deliveryTimeTo ?? _deliveryTimeTo,
  slottime: slottime ?? _slottime,
  status: status ?? _status,
  note: note ?? _note,
  isPaid: isPaid ?? _isPaid,
  shippingCharge: shippingCharge ?? _shippingCharge,
  couponDiscount: couponDiscount ?? _couponDiscount,
  couponCode: couponCode ?? _couponCode,
  totalAmount: totalAmount ?? _totalAmount,
  totalRewards: totalRewards ?? _totalRewards,
  totalKg: totalKg ?? _totalKg,
  totalItems: totalItems ?? _totalItems,
  socityId: socityId ?? _socityId,
  addressId: addressId ?? _addressId,
  deliveryAddress: deliveryAddress ?? _deliveryAddress,
  area: area ?? _area,
  locationId: locationId ?? _locationId,
  deliveryCharge: deliveryCharge ?? _deliveryCharge,
  newStoreId: newStoreId ?? _newStoreId,
  assignTo: assignTo ?? _assignTo,
  paymentMethod: paymentMethod ?? _paymentMethod,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  email: email ?? _email,
  phoneNo: phoneNo ?? _phoneNo,
  zipCode: zipCode ?? _zipCode,
  dateTime: dateTime ?? _dateTime,
  deliveryboyOrderStatus: deliveryboyOrderStatus ?? _deliveryboyOrderStatus,
  assignedTime: assignedTime ?? _assignedTime,
  isStatus: isStatus ?? _isStatus,
  deliveryLatitude: deliveryLatitude ?? _deliveryLatitude,
  deliveryLongitude: deliveryLongitude ?? _deliveryLongitude,
  orderReceivedTime: orderReceivedTime ?? _orderReceivedTime,
  foodPrepareTime: foodPrepareTime ?? _foodPrepareTime,
  orderPickupTime: orderPickupTime ?? _orderPickupTime,
  orderDeliveredTime: orderDeliveredTime ?? _orderDeliveredTime,
  orderTimeComplete: orderTimeComplete ?? _orderTimeComplete,
  city: city ?? _city,
  distance: distance ?? _distance,
  reciverFullAddress: reciverFullAddress ?? _reciverFullAddress,
  senderLatitude: senderLatitude ?? _senderLatitude,
  senderLongitude: senderLongitude ?? _senderLongitude,
  receiverLatitude: receiverLatitude ?? _receiverLatitude,
  receiverLongitude: receiverLongitude ?? _receiverLongitude,
  parcelPhoto: parcelPhoto ?? _parcelPhoto,
  isCodOrderVerify: isCodOrderVerify ?? _isCodOrderVerify,
  accountName: accountName ?? _accountName,
  accountNumber: accountNumber ?? _accountNumber,
  parcelHistory: parcelHistory ?? _parcelHistory,
  materialInfo: materialInfo ?? _materialInfo,

);
  String? get saleId => _saleId;
  String? get orderId => _orderId;
  String? get barcode => _barcode;
  String? get barcodeLink => _barcodeLink;
  String? get userId => _userId;
  String? get deliveryBoyId => _deliveryBoyId;
  String? get bookingRef => _bookingRef;
  String? get senderName => _senderName;
  String? get senderAddress => _senderAddress;
  String? get senderFulladdress => _senderFulladdress;
  String? get receiverName => _receiverName;
  String? get receiverPhone => _receiverPhone;
  String? get receiverAddress => _receiverAddress;
  String? get reqDeliveryboyIds => _reqDeliveryboyIds;
  String? get onDate => _onDate;
  String? get deliveryTimeFrom => _deliveryTimeFrom;
  String? get deliveryTimeTo => _deliveryTimeTo;
  String? get slottime => _slottime;
  String? get status => _status;
  String? get note => _note;
  String? get isPaid => _isPaid;
  String? get shippingCharge => _shippingCharge;
  String? get couponDiscount => _couponDiscount;
  String? get couponCode => _couponCode;
  String? get totalAmount => _totalAmount;
  String? get totalRewards => _totalRewards;
  String? get totalKg => _totalKg;
  String? get totalItems => _totalItems;
  String? get socityId => _socityId;
  String? get addressId => _addressId;
  String? get deliveryAddress => _deliveryAddress;
  String? get area => _area;
  String? get locationId => _locationId;
  String? get deliveryCharge => _deliveryCharge;
  String? get newStoreId => _newStoreId;
  String? get assignTo => _assignTo;
  String? get paymentMethod => _paymentMethod;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get phoneNo => _phoneNo;
  String? get zipCode => _zipCode;
  String? get dateTime => _dateTime;
  String? get deliveryboyOrderStatus => _deliveryboyOrderStatus;
  String? get assignedTime => _assignedTime;
  String? get isStatus => _isStatus;
  String? get deliveryLatitude => _deliveryLatitude;
  String? get deliveryLongitude => _deliveryLongitude;
  String? get orderReceivedTime => _orderReceivedTime;
  String? get foodPrepareTime => _foodPrepareTime;
  String? get orderPickupTime => _orderPickupTime;
  String? get orderDeliveredTime => _orderDeliveredTime;
  String? get orderTimeComplete => _orderTimeComplete;
  String? get city => _city;
  String? get distance => _distance;
  String? get reciverFullAddress => _reciverFullAddress;
  String? get senderLatitude => _senderLatitude;
  String? get senderLongitude => _senderLongitude;
  String? get receiverLatitude => _receiverLatitude;
  String? get receiverLongitude => _receiverLongitude;
  String? get parcelPhoto => _parcelPhoto;
  String? get isCodOrderVerify => _isCodOrderVerify;
  String? get accountName => _accountName;
  String? get accountNumber => _accountNumber;
  String? get parcelHistory => _parcelHistory;
  MaterialInfo? get materialInfo => _materialInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sale_id'] = _saleId;
    map['order_id'] = _orderId;
    map['barcode'] = _barcode;
    map['barcode_link'] = _barcodeLink;
    map['user_id'] = _userId;
    map['delivery_boy_id'] = _deliveryBoyId;
    map['booking_ref'] = _bookingRef;
    map['sender_name'] = _senderName;
    map['sender_address'] = _senderAddress;
    map['sender_fulladdress'] = _senderFulladdress;
    map['receiver_name'] = _receiverName;
    map['receiver_phone'] = _receiverPhone;
    map['receiver_address'] = _receiverAddress;
    map['req_deliveryboy_ids'] = _reqDeliveryboyIds;
    map['on_date'] = _onDate;
    map['delivery_time_from'] = _deliveryTimeFrom;
    map['delivery_time_to'] = _deliveryTimeTo;
    map['slottime'] = _slottime;
    map['status'] = _status;
    map['note'] = _note;
    map['is_paid'] = _isPaid;
    map['shipping_charge'] = _shippingCharge;
    map['coupon_discount'] = _couponDiscount;
    map['coupon_code'] = _couponCode;
    map['total_amount'] = _totalAmount;
    map['total_rewards'] = _totalRewards;
    map['total_kg'] = _totalKg;
    map['total_items'] = _totalItems;
    map['socity_id'] = _socityId;
    map['address_id'] = _addressId;
    map['delivery_address'] = _deliveryAddress;
    map['area'] = _area;
    map['location_id'] = _locationId;
    map['delivery_charge'] = _deliveryCharge;
    map['new_store_id'] = _newStoreId;
    map['assign_to'] = _assignTo;
    map['payment_method'] = _paymentMethod;
    map['First_name'] = _firstName;
    map['Last_name'] = _lastName;
    map['email'] = _email;
    map['phone_no'] = _phoneNo;
    map['zip_code'] = _zipCode;
    map['date_time'] = _dateTime;
    map['deliveryboy_order_status'] = _deliveryboyOrderStatus;
    map['assigned_time'] = _assignedTime;
    map['is_status'] = _isStatus;
    map['delivery_latitude'] = _deliveryLatitude;
    map['delivery_longitude'] = _deliveryLongitude;
    map['order_received_time'] = _orderReceivedTime;
    map['food_prepare_time'] = _foodPrepareTime;
    map['order_pickup_time'] = _orderPickupTime;
    map['order_delivered_time'] = _orderDeliveredTime;
    map['order_time_complete'] = _orderTimeComplete;
    map['city'] = _city;
    map['distance'] = _distance;
    map['reciver_full_address'] = _reciverFullAddress;
    map['sender_latitude'] = _senderLatitude;
    map['sender_longitude'] = _senderLongitude;
    map['receiver_latitude'] = _receiverLatitude;
    map['receiver_longitude'] = _receiverLongitude;
    map['parcel_photo'] = _parcelPhoto;
    map['is_cod_order_verify'] = _isCodOrderVerify;
    map['account_name'] = _accountName;
    map['account_number'] = _accountNumber;
    map['parcel_history'] = _parcelHistory;
    if (_materialInfo != null) {
      map['material_info'] = _materialInfo?.toJson();
    }
    return map;
  }

}

/// sale_item_id : "1"
/// sale_id : "1"
/// product_id : "0"
/// product_name : ""
/// qty : "0"
/// unit : ""
/// unit_value : "0"
/// price : "40"
/// qty_in_kg : "0"
/// rewards : ""
/// discountprice : "0"
/// meterial_category : "15"
/// parcel_weight : "up to 20 kg"

class MaterialInfo {
  MaterialInfo({
      String? saleItemId, 
      String? saleId, 
      String? productId, 
      String? productName, 
      String? qty, 
      String? unit, 
      String? unitValue, 
      String? price, 
      String? qtyInKg, 
      String? rewards, 
      String? discountprice, 
      String? meterialCategory, 
      String? parcelWeight,}){
    _saleItemId = saleItemId;
    _saleId = saleId;
    _productId = productId;
    _productName = productName;
    _qty = qty;
    _unit = unit;
    _unitValue = unitValue;
    _price = price;
    _qtyInKg = qtyInKg;
    _rewards = rewards;
    _discountprice = discountprice;
    _meterialCategory = meterialCategory;
    _parcelWeight = parcelWeight;
}

  MaterialInfo.fromJson(dynamic json) {
    _saleItemId = json['sale_item_id'];
    _saleId = json['sale_id'];
    _productId = json['product_id'];
    _productName = json['product_name'];
    _qty = json['qty'];
    _unit = json['unit'];
    _unitValue = json['unit_value'];
    _price = json['price'];
    _qtyInKg = json['qty_in_kg'];
    _rewards = json['rewards'];
    _discountprice = json['discountprice'];
    _meterialCategory = json['meterial_category'];
    _parcelWeight = json['parcel_weight'];
  }
  String? _saleItemId;
  String? _saleId;
  String? _productId;
  String? _productName;
  String? _qty;
  String? _unit;
  String? _unitValue;
  String? _price;
  String? _qtyInKg;
  String? _rewards;
  String? _discountprice;
  String? _meterialCategory;
  String? _parcelWeight;
MaterialInfo copyWith({  String? saleItemId,
  String? saleId,
  String? productId,
  String? productName,
  String? qty,
  String? unit,
  String? unitValue,
  String? price,
  String? qtyInKg,
  String? rewards,
  String? discountprice,
  String? meterialCategory,
  String? parcelWeight,
}) => MaterialInfo(  saleItemId: saleItemId ?? _saleItemId,
  saleId: saleId ?? _saleId,
  productId: productId ?? _productId,
  productName: productName ?? _productName,
  qty: qty ?? _qty,
  unit: unit ?? _unit,
  unitValue: unitValue ?? _unitValue,
  price: price ?? _price,
  qtyInKg: qtyInKg ?? _qtyInKg,
  rewards: rewards ?? _rewards,
  discountprice: discountprice ?? _discountprice,
  meterialCategory: meterialCategory ?? _meterialCategory,
  parcelWeight: parcelWeight ?? _parcelWeight,
);
  String? get saleItemId => _saleItemId;
  String? get saleId => _saleId;
  String? get productId => _productId;
  String? get productName => _productName;
  String? get qty => _qty;
  String? get unit => _unit;
  String? get unitValue => _unitValue;
  String? get price => _price;
  String? get qtyInKg => _qtyInKg;
  String? get rewards => _rewards;
  String? get discountprice => _discountprice;
  String? get meterialCategory => _meterialCategory;
  String? get parcelWeight => _parcelWeight;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sale_item_id'] = _saleItemId;
    map['sale_id'] = _saleId;
    map['product_id'] = _productId;
    map['product_name'] = _productName;
    map['qty'] = _qty;
    map['unit'] = _unit;
    map['unit_value'] = _unitValue;
    map['price'] = _price;
    map['qty_in_kg'] = _qtyInKg;
    map['rewards'] = _rewards;
    map['discountprice'] = _discountprice;
    map['meterial_category'] = _meterialCategory;
    map['parcel_weight'] = _parcelWeight;
    return map;
  }

}