import 'dart:convert';
EmployeeData employeeDataFromJson(String str) => EmployeeData.fromJson(json.decode(str));
String employeeDataToJson(EmployeeData data) => json.encode(data.toJson());
class EmployeeData {
  EmployeeData({
      this.id, 
      this.name, 
      this.phone, 
      this.email,});

  EmployeeData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
  }
  String? id;
  String? name;
  String? phone;
  String? email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['phone'] = phone;
    map['email'] = email;
    return map;
  }

}