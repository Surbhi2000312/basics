import 'dart:convert';
TimeModel timeModelFromJson(String str) => TimeModel.fromJson(json.decode(str));
String timeModelToJson(TimeModel data) => json.encode(data.toJson());
class TimeModel {
  TimeModel({
      this.time, 
      this.timeFormat,
      this.uniqueId
  });

  TimeModel.fromJson(dynamic json) {
    time = json['time'];
    timeFormat = json['timeFormat'];
    uniqueId = json['uniqueId'];
  }
  String? time;
  String? timeFormat;
  int? uniqueId;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['time'] = time;
    map['timeFormat'] = timeFormat;
    map['uniqueId'] = uniqueId;
    return map;
  }

}