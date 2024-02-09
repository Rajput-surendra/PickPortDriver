/// status : true
/// data : [{"order_id":"121","title":"Agricultural Equipment","shipping_charge":"0","parcel_weight":"0","admin_commission":"0","driver_amount":"0"}]
/// message : "successfully"

class DriverEarnModel {
  DriverEarnModel({
      bool? status, 
      List<Data>? data, 
      String? message,}){
    _status = status;
    _data = data;
    _message = message;
}

  DriverEarnModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _message = json['message'];
  }
  bool? _status;
  List<Data>? _data;
  String? _message;
DriverEarnModel copyWith({  bool? status,
  List<Data>? data,
  String? message,
}) => DriverEarnModel(  status: status ?? _status,
  data: data ?? _data,
  message: message ?? _message,
);
  bool? get status => _status;
  List<Data>? get data => _data;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    return map;
  }

}

/// order_id : "121"
/// title : "Agricultural Equipment"
/// shipping_charge : "0"
/// parcel_weight : "0"
/// admin_commission : "0"
/// driver_amount : "0"

class Data {
  Data({
      String? orderId, 
      String? title, 
      String? shippingCharge, 
      String? parcelWeight, 
      String? adminCommission, 
      String? driverAmount,}){
    _orderId = orderId;
    _title = title;
    _shippingCharge = shippingCharge;
    _parcelWeight = parcelWeight;
    _adminCommission = adminCommission;
    _driverAmount = driverAmount;
}

  Data.fromJson(dynamic json) {
    _orderId = json['order_id'];
    _title = json['title'];
    _shippingCharge = json['shipping_charge'];
    _parcelWeight = json['parcel_weight'];
    _adminCommission = json['admin_commission'];
    _driverAmount = json['driver_amount'];
  }
  String? _orderId;
  String? _title;
  String? _shippingCharge;
  String? _parcelWeight;
  String? _adminCommission;
  String? _driverAmount;
Data copyWith({  String? orderId,
  String? title,
  String? shippingCharge,
  String? parcelWeight,
  String? adminCommission,
  String? driverAmount,
}) => Data(  orderId: orderId ?? _orderId,
  title: title ?? _title,
  shippingCharge: shippingCharge ?? _shippingCharge,
  parcelWeight: parcelWeight ?? _parcelWeight,
  adminCommission: adminCommission ?? _adminCommission,
  driverAmount: driverAmount ?? _driverAmount,
);
  String? get orderId => _orderId;
  String? get title => _title;
  String? get shippingCharge => _shippingCharge;
  String? get parcelWeight => _parcelWeight;
  String? get adminCommission => _adminCommission;
  String? get driverAmount => _driverAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_id'] = _orderId;
    map['title'] = _title;
    map['shipping_charge'] = _shippingCharge;
    map['parcel_weight'] = _parcelWeight;
    map['admin_commission'] = _adminCommission;
    map['driver_amount'] = _driverAmount;
    return map;
  }

}