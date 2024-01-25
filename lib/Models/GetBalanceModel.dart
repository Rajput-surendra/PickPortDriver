/// error : false
/// message : "Data Get Sucessfully"
/// data : {"id":"1","amt":"200"}

class GetBalanceModel {
  GetBalanceModel({
      bool? error, 
      String? message, 
      Data? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetBalanceModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _error;
  String? _message;
  Data? _data;
GetBalanceModel copyWith({  bool? error,
  String? message,
  Data? data,
}) => GetBalanceModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// id : "1"
/// amt : "200"

class Data {
  Data({
      String? id, 
      String? amt,}){
    _id = id;
    _amt = amt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _amt = json['amt'];
  }
  String? _id;
  String? _amt;
Data copyWith({  String? id,
  String? amt,
}) => Data(  id: id ?? _id,
  amt: amt ?? _amt,
);
  String? get id => _id;
  String? get amt => _amt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['amt'] = _amt;
    return map;
  }
}