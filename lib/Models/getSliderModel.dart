/// status : true
/// message : "Drivery List"
/// data : [{"id":"3","type":"2","slider_title":"today highlight","slider_url":"","slider_image":"imgpsh_fullsize_anim_(2).png","sub_cat":"68","slider_status":"0"}]

class GetSliderModel {
  GetSliderModel({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetSliderModel.fromJson(dynamic json) {
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
GetSliderModel copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => GetSliderModel(  status: status ?? _status,
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

/// id : "3"
/// type : "2"
/// slider_title : "today highlight"
/// slider_url : ""
/// slider_image : "imgpsh_fullsize_anim_(2).png"
/// sub_cat : "68"
/// slider_status : "0"

class Data {
  Data({
      String? id, 
      String? type, 
      String? sliderTitle, 
      String? sliderUrl, 
      String? sliderImage, 
      String? subCat, 
      String? sliderStatus,}){
    _id = id;
    _type = type;
    _sliderTitle = sliderTitle;
    _sliderUrl = sliderUrl;
    _sliderImage = sliderImage;
    _subCat = subCat;
    _sliderStatus = sliderStatus;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _sliderTitle = json['slider_title'];
    _sliderUrl = json['slider_url'];
    _sliderImage = json['slider_image'];
    _subCat = json['sub_cat'];
    _sliderStatus = json['slider_status'];
  }
  String? _id;
  String? _type;
  String? _sliderTitle;
  String? _sliderUrl;
  String? _sliderImage;
  String? _subCat;
  String? _sliderStatus;
Data copyWith({  String? id,
  String? type,
  String? sliderTitle,
  String? sliderUrl,
  String? sliderImage,
  String? subCat,
  String? sliderStatus,
}) => Data(  id: id ?? _id,
  type: type ?? _type,
  sliderTitle: sliderTitle ?? _sliderTitle,
  sliderUrl: sliderUrl ?? _sliderUrl,
  sliderImage: sliderImage ?? _sliderImage,
  subCat: subCat ?? _subCat,
  sliderStatus: sliderStatus ?? _sliderStatus,
);
  String? get id => _id;
  String? get type => _type;
  String? get sliderTitle => _sliderTitle;
  String? get sliderUrl => _sliderUrl;
  String? get sliderImage => _sliderImage;
  String? get subCat => _subCat;
  String? get sliderStatus => _sliderStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['slider_title'] = _sliderTitle;
    map['slider_url'] = _sliderUrl;
    map['slider_image'] = _sliderImage;
    map['sub_cat'] = _subCat;
    map['slider_status'] = _sliderStatus;
    return map;
  }

}