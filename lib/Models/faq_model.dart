/// status : true
/// message : "List of FAQ."
/// data : [{"id":"1","question":"FAQ-1 asdasd","answer":"<p><strong>asd</strong> asdasdads asdasdasd as asf</p>\r\n"}]

class FaqModel {
  FaqModel({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  FaqModel.fromJson(dynamic json) {
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
FaqModel copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => FaqModel(  status: status ?? _status,
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

/// id : "1"
/// question : "FAQ-1 asdasd"
/// answer : "<p><strong>asd</strong> asdasdads asdasdasd as asf</p>\r\n"

class Data {
  Data({
      String? id, 
      String? question, 
      String? answer,}){
    _id = id;
    _question = question;
    _answer = answer;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _question = json['question'];
    _answer = json['answer'];
  }
  String? _id;
  String? _question;
  String? _answer;
Data copyWith({  String? id,
  String? question,
  String? answer,
}) => Data(  id: id ?? _id,
  question: question ?? _question,
  answer: answer ?? _answer,
);
  String? get id => _id;
  String? get question => _question;
  String? get answer => _answer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['question'] = _question;
    map['answer'] = _answer;
    return map;
  }

}