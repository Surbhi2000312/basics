import 'dart:convert';
GenerateList generateListFromJson(String str) => GenerateList.fromJson(json.decode(str));
String generateListToJson(GenerateList data) => json.encode(data.toJson());
class GenerateList {
  GenerateList({
      this.list, 
      this.newListNumber,});

  GenerateList.fromJson(dynamic json) {
    if (json['list'] != null) {
      list = [];
      json['list'].forEach((v) {
        list?.add(Dynamic.fromJson(v));
      });
    }
    newListNumber = json['newListNumber'];
  }


  List<dynamic>? list;
  String? newListNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (list != null) {
      map['list'] = list?.map((v) => v.toJson()).toList();
    }
    map['newListNumber'] = newListNumber;
    return map;
  }

}

class Dynamic {
  String? value;

  Dynamic({this.value});

  Dynamic.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = value;
    return map;
  }
}