/// status : true
/// data : [{"city_id":"4","city_name":"Gwalior","state_id":"9","status":"1"},{"city_id":"5","city_name":"Ujjain","state_id":"9","status":"1"},{"city_id":"6","city_name":"Sagar","state_id":"9","status":"1"},{"city_id":"7","city_name":"Dewas","state_id":"9","status":"1"},{"city_id":"8","city_name":"Satna","state_id":"9","status":"1"},{"city_id":"9","city_name":"Ratlam","state_id":"9","status":"1"},{"city_id":"10","city_name":"Rewa","state_id":"9","status":"1"},{"city_id":"11","city_name":"Katni","state_id":"9","status":"1"},{"city_id":"12","city_name":"Singrauli","state_id":"9","status":"1"},{"city_id":"13","city_name":"Burhanpur","state_id":"9","status":"1"},{"city_id":"14","city_name":"Khandwa","state_id":"9","status":"1"},{"city_id":"15","city_name":"Bhind","state_id":"9","status":"1"},{"city_id":"16","city_name":"Chhindwara","state_id":"9","status":"1"},{"city_id":"17","city_name":"Guna","state_id":"9","status":"1"},{"city_id":"18","city_name":"Shivpuri","state_id":"9","status":"1"},{"city_id":"19","city_name":"Vidisha","state_id":"9","status":"1"},{"city_id":"20","city_name":"Chhatarpur","state_id":"9","status":"1"},{"city_id":"21","city_name":"Damoh","state_id":"9","status":"1"},{"city_id":"22","city_name":"Mandsaur","state_id":"9","status":"1"},{"city_id":"23","city_name":"Khargone","state_id":"9","status":"1"},{"city_id":"24","city_name":"Neemuch","state_id":"9","status":"1"},{"city_id":"25","city_name":"Pithampur","state_id":"9","status":"1"},{"city_id":"26","city_name":"Narmadapuram","state_id":"9","status":"1"},{"city_id":"27","city_name":"Itarsi","state_id":"9","status":"1"},{"city_id":"28","city_name":"Sehore","state_id":"9","status":"1"},{"city_id":"29","city_name":"Chambal","state_id":"9","status":"1"},{"city_id":"30","city_name":"Betul","state_id":"9","status":"1"},{"city_id":"31","city_name":"Seoni","state_id":"9","status":"1"},{"city_id":"32","city_name":"Datia","state_id":"9","status":"1"},{"city_id":"33","city_name":"Nagda","state_id":"9","status":"1"},{"city_id":"34","city_name":"Dindori","state_id":"9","status":"1"},{"city_id":"35","city_name":"Indore","state_id":"9","status":"1"},{"city_id":"36","city_name":"Bhopal","state_id":"9","status":"1"},{"city_id":"37","city_name":"Jabalpur","state_id":"9","status":"1"}]
/// message : "All Citys "

class GetCityModel {
  GetCityModel({
      bool? status, 
      List<GetStateList>? data,
      String? message,}){
    _status = status;
    _data = data;
    _message = message;
}

  GetCityModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(GetStateList.fromJson(v));
      });
    }
    _message = json['message'];
  }
  bool? _status;
  List<GetStateList>? _data;
  String? _message;
GetCityModel copyWith({  bool? status,
  List<GetStateList>? data,
  String? message,
}) => GetCityModel(  status: status ?? _status,
  data: data ?? _data,
  message: message ?? _message,
);
  bool? get status => _status;
  List<GetStateList>? get data => _data;
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

/// city_id : "4"
/// city_name : "Gwalior"
/// state_id : "9"
/// status : "1"

class GetStateList {
  GetStateList({
      String? cityId, 
      String? cityName, 
      String? stateId, 
      String? status,}){
    _cityId = cityId;
    _cityName = cityName;
    _stateId = stateId;
    _status = status;
}

  GetStateList.fromJson(dynamic json) {
    _cityId = json['city_id'];
    _cityName = json['city_name'];
    _stateId = json['state_id'];
    _status = json['status'];
  }
  String? _cityId;
  String? _cityName;
  String? _stateId;
  String? _status;
  GetStateList copyWith({  String? cityId,
  String? cityName,
  String? stateId,
  String? status,
}) => GetStateList(  cityId: cityId ?? _cityId,
  cityName: cityName ?? _cityName,
  stateId: stateId ?? _stateId,
  status: status ?? _status,
);
  String? get cityId => _cityId;
  String? get cityName => _cityName;
  String? get stateId => _stateId;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['city_id'] = _cityId;
    map['city_name'] = _cityName;
    map['state_id'] = _stateId;
    map['status'] = _status;
    return map;
  }

}