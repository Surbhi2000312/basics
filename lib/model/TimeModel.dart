import 'dart:convert';
TimeModel timeModelFromJson(String str) => TimeModel.fromJson(json.decode(str));
String timeModelToJson(TimeModel data) => json.encode(data.toJson());
class TimeModel {
  TimeModel({
      this.time, 
      this.timeFormat,
      this.uniqueId,
      this.uniqueListId
  });

  TimeModel.fromJson(dynamic json) {
    time = json['time'];
    timeFormat = json['timeFormat'];
    uniqueId = json['uniqueId'];
    uniqueListId = json['uniqueId'];

  }
  String? time;
  String? timeFormat;
  int? uniqueId;
  String? uniqueListId;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['time'] = time;
    map['timeFormat'] = timeFormat;
    map['uniqueId'] = uniqueId;
    map['uniqueListId'] = uniqueListId;

    return map;
  }

}