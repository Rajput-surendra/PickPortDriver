/// error : false
/// message : "Data Successfully Get !"
/// data : [{"id":"3","title":"We are Pickport & <br /> transport company ","description":" Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laboreLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laboreLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laboreLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laboreLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore","image":"jahaj.png","image2":"","image3":"","type":"2"}]

class AboutModel {
  AboutModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  AboutModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<Data>? _data;
AboutModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => AboutModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "3"
/// title : "We are Pickport & <br /> transport company "
/// description : " Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laboreLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laboreLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laboreLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laboreLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore"
/// image : "jahaj.png"
/// image2 : ""
/// image3 : ""
/// type : "2"

class Data {
  Data({
      String? id, 
      String? title, 
      String? description, 
      String? image, 
      String? image2, 
      String? image3, 
      String? type,}){
    _id = id;
    _title = title;
    _description = description;
    _image = image;
    _image2 = image2;
    _image3 = image3;
    _type = type;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _image = json['image'];
    _image2 = json['image2'];
    _image3 = json['image3'];
    _type = json['type'];
  }
  String? _id;
  String? _title;
  String? _description;
  String? _image;
  String? _image2;
  String? _image3;
  String? _type;
Data copyWith({  String? id,
  String? title,
  String? description,
  String? image,
  String? image2,
  String? image3,
  String? type,
}) => Data(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
  image: image ?? _image,
  image2: image2 ?? _image2,
  image3: image3 ?? _image3,
  type: type ?? _type,
);
  String? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get image => _image;
  String? get image2 => _image2;
  String? get image3 => _image3;
  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['image'] = _image;
    map['image2'] = _image2;
    map['image3'] = _image3;
    map['type'] = _type;
    return map;
  }

}