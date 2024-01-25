/// status : true
/// data : [{"state_id":"2","state_name":"Kolkata"},{"state_id":"8","state_name":"Metro cities"},{"state_id":"9","state_name":"Across All India"}]
/// message : "All States "

class GetStatusModel {
  GetStatusModel({
      bool? status, 
      List<GetCityList>? data,
      String? message,}){
    _status = status;
    _data = data;
    _message = message;
}

  GetStatusModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(GetCityList.fromJson(v));
      });
    }
    _message = json['message'];
  }
  bool? _status;
  List<GetCityList>? _data;
  String? _message;
GetStatusModel copyWith({  bool? status,
  List<GetCityList>? data,
  String? message,
}) => GetStatusModel(  status: status ?? _status,
  data: data ?? _data,
  message: message ?? _message,
);
  bool? get status => _status;
  List<GetCityList>? get data => _data;
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

/// state_id : "2"
/// state_name : "Kolkata"

class GetCityList {
  GetCityList({
      String? stateId, 
      String? stateName,}){
    _stateId = stateId;
    _stateName = stateName;
}

  GetCityList.fromJson(dynamic json) {
    _stateId = json['state_id'];
    _stateName = json['state_name'];
  }
  String? _stateId;
  String? _stateName;
  GetCityList copyWith({  String? stateId,
  String? stateName,
}) => GetCityList(  stateId: stateId ?? _stateId,
  stateName: stateName ?? _stateName,
);
  String? get stateId => _stateId;
  String? get stateName => _stateName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['state_id'] = _stateId;
    map['state_name'] = _stateName;
    return map;
  }

}