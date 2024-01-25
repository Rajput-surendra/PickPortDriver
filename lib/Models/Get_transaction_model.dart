/// status : true
/// message : "Get All Wallet ."
/// data : [{"id":"17","user_id":"349","amount":"0","sign":"+","payment_type":"Deposit","payment_status":"Success","payment_method":"0","order_id":"0","create_dt":"1703930521","update_dt":"1703930521","status":"0","wallet_status":"0","notes":"","date":"2023-12-30 15:32:01"}]

class GetTransactionModel {
  GetTransactionModel({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetTransactionModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Data>? _data;
GetTransactionModel copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => GetTransactionModel(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "17"
/// user_id : "349"
/// amount : "0"
/// sign : "+"
/// payment_type : "Deposit"
/// payment_status : "Success"
/// payment_method : "0"
/// order_id : "0"
/// create_dt : "1703930521"
/// update_dt : "1703930521"
/// status : "0"
/// wallet_status : "0"
/// notes : ""
/// date : "2023-12-30 15:32:01"

class Data {
  Data({
      String? id, 
      String? userId, 
      String? amount, 
      String? sign, 
      String? paymentType, 
      String? paymentStatus, 
      String? paymentMethod, 
      String? orderId, 
      String? createDt, 
      String? updateDt, 
      String? status, 
      String? walletStatus, 
      String? notes, 
      String? date,}){
    _id = id;
    _userId = userId;
    _amount = amount;
    _sign = sign;
    _paymentType = paymentType;
    _paymentStatus = paymentStatus;
    _paymentMethod = paymentMethod;
    _orderId = orderId;
    _createDt = createDt;
    _updateDt = updateDt;
    _status = status;
    _walletStatus = walletStatus;
    _notes = notes;
    _date = date;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _amount = json['amount'];
    _sign = json['sign'];
    _paymentType = json['payment_type'];
    _paymentStatus = json['payment_status'];
    _paymentMethod = json['payment_method'];
    _orderId = json['order_id'];
    _createDt = json['create_dt'];
    _updateDt = json['update_dt'];
    _status = json['status'];
    _walletStatus = json['wallet_status'];
    _notes = json['notes'];
    _date = json['date'];
  }
  String? _id;
  String? _userId;
  String? _amount;
  String? _sign;
  String? _paymentType;
  String? _paymentStatus;
  String? _paymentMethod;
  String? _orderId;
  String? _createDt;
  String? _updateDt;
  String? _status;
  String? _walletStatus;
  String? _notes;
  String? _date;
Data copyWith({  String? id,
  String? userId,
  String? amount,
  String? sign,
  String? paymentType,
  String? paymentStatus,
  String? paymentMethod,
  String? orderId,
  String? createDt,
  String? updateDt,
  String? status,
  String? walletStatus,
  String? notes,
  String? date,
}) => Data(  id: id ?? _id,
  userId: userId ?? _userId,
  amount: amount ?? _amount,
  sign: sign ?? _sign,
  paymentType: paymentType ?? _paymentType,
  paymentStatus: paymentStatus ?? _paymentStatus,
  paymentMethod: paymentMethod ?? _paymentMethod,
  orderId: orderId ?? _orderId,
  createDt: createDt ?? _createDt,
  updateDt: updateDt ?? _updateDt,
  status: status ?? _status,
  walletStatus: walletStatus ?? _walletStatus,
  notes: notes ?? _notes,
  date: date ?? _date,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get amount => _amount;
  String? get sign => _sign;
  String? get paymentType => _paymentType;
  String? get paymentStatus => _paymentStatus;
  String? get paymentMethod => _paymentMethod;
  String? get orderId => _orderId;
  String? get createDt => _createDt;
  String? get updateDt => _updateDt;
  String? get status => _status;
  String? get walletStatus => _walletStatus;
  String? get notes => _notes;
  String? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['amount'] = _amount;
    map['sign'] = _sign;
    map['payment_type'] = _paymentType;
    map['payment_status'] = _paymentStatus;
    map['payment_method'] = _paymentMethod;
    map['order_id'] = _orderId;
    map['create_dt'] = _createDt;
    map['update_dt'] = _updateDt;
    map['status'] = _status;
    map['wallet_status'] = _walletStatus;
    map['notes'] = _notes;
    map['date'] = _date;
    return map;
  }

}