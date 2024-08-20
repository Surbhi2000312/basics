import 'dart:convert';
DateModel dateModelFromJson(String str) => DateModel.fromJson(json.decode(str));
String dateModelToJson(DateModel data) => json.encode(data.toJson());
class DateModel {


  DateModel({
      this.date,
      this.day
  });


  DateModel.fromJson(dynamic json) {
    date = json['date'];
    day = json['day'];
  }
  String? date;
  String? day;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = date;
    map['day'] = day;
    return map;
  }

}