/// status : true
/// message : "Data Get Successfully"
/// data : {"id":"1","phone_no":"9876543210","phone_no1":"9876543210","email":"customer@pickport.com","email2":"customer@pickport.com","whatsapp_no":"9876543210","whatsapp_no1":"9876543210","address":"Indore Bypass Area","order_commision":"0","compensation":"0","live_url":""}

class NewContectModel {
  NewContectModel({
    bool? status,
    String? message,
    Data? data,}){
    _status = status;
    _message = message;
    _data = data;
  }

  NewContectModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;
  NewContectModel copyWith({  bool? status,
    String? message,
    Data? data,
  }) => NewContectModel(  status: status ?? _status,
    message: message ?? _message,
    data: data ?? _data,
  );
  bool? get status => _status;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// id : "1"
/// phone_no : "9876543210"
/// phone_no1 : "9876543210"
/// email : "customer@pickport.com"
/// email2 : "customer@pickport.com"
/// whatsapp_no : "9876543210"
/// whatsapp_no1 : "9876543210"
/// address : "Indore Bypass Area"
/// order_commision : "0"
/// compensation : "0"
/// live_url : ""

class Data {
  Data({
    String? id,
    String? phoneNo,
    String? phoneNo1,
    String? email,
    String? email2,
    String? whatsappNo,
    String? whatsappNo1,
    String? address,
    String? orderCommision,
    String? compensation,
    String? liveUrl,}){
    _id = id;
    _phoneNo = phoneNo;
    _phoneNo1 = phoneNo1;
    _email = email;
    _email2 = email2;
    _whatsappNo = whatsappNo;
    _whatsappNo1 = whatsappNo1;
    _address = address;
    _orderCommision = orderCommision;
    _compensation = compensation;
    _liveUrl = liveUrl;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _phoneNo = json['phone_no'];
    _phoneNo1 = json['phone_no1'];
    _email = json['email'];
    _email2 = json['email2'];
    _whatsappNo = json['whatsapp_no'];
    _whatsappNo1 = json['whatsapp_no1'];
    _address = json['address'];
    _orderCommision = json['order_commision'];
    _compensation = json['compensation'];
    _liveUrl = json['live_url'];
  }
  String? _id;
  String? _phoneNo;
  String? _phoneNo1;
  String? _email;
  String? _email2;
  String? _whatsappNo;
  String? _whatsappNo1;
  String? _address;
  String? _orderCommision;
  String? _compensation;
  String? _liveUrl;
  Data copyWith({  String? id,
    String? phoneNo,
    String? phoneNo1,
    String? email,
    String? email2,
    String? whatsappNo,
    String? whatsappNo1,
    String? address,
    String? orderCommision,
    String? compensation,
    String? liveUrl,
  }) => Data(  id: id ?? _id,
    phoneNo: phoneNo ?? _phoneNo,
    phoneNo1: phoneNo1 ?? _phoneNo1,
    email: email ?? _email,
    email2: email2 ?? _email2,
    whatsappNo: whatsappNo ?? _whatsappNo,
    whatsappNo1: whatsappNo1 ?? _whatsappNo1,
    address: address ?? _address,
    orderCommision: orderCommision ?? _orderCommision,
    compensation: compensation ?? _compensation,
    liveUrl: liveUrl ?? _liveUrl,
  );
  String? get id => _id;
  String? get phoneNo => _phoneNo;
  String? get phoneNo1 => _phoneNo1;
  String? get email => _email;
  String? get email2 => _email2;
  String? get whatsappNo => _whatsappNo;
  String? get whatsappNo1 => _whatsappNo1;
  String? get address => _address;
  String? get orderCommision => _orderCommision;
  String? get compensation => _compensation;
  String? get liveUrl => _liveUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['phone_no'] = _phoneNo;
    map['phone_no1'] = _phoneNo1;
    map['email'] = _email;
    map['email2'] = _email2;
    map['whatsapp_no'] = _whatsappNo;
    map['whatsapp_no1'] = _whatsappNo1;
    map['address'] = _address;
    map['order_commision'] = _orderCommision;
    map['compensation'] = _compensation;
    map['live_url'] = _liveUrl;
    return map;
  }

}