class PostModel {
  PostModel({
      this.date, 
      this.localName, 
      this.name, 
      this.countryCode, 
      this.fixed, 
      this.global, 
      this.counties, 
      this.launchYear, 
      this.type,});

  PostModel.fromJson(dynamic json) {
    date = json['date'];
    localName = json['localName'];
    name = json['name'];
    countryCode = json['countryCode'];
    fixed = json['fixed'];
    global = json['global'];
    counties = json['counties'];
    launchYear = json['launchYear'];
    type = json['type'];
  }
  String? date;
  String? localName;
  String? name;
  String? countryCode;
  bool? fixed;
  bool? global;
  dynamic counties;
  dynamic launchYear;
  String? type;
PostModel copyWith({  String? date,
  String? localName,
  String? name,
  String? countryCode,
  bool? fixed,
  bool? global,
  dynamic counties,
  dynamic launchYear,
  String? type,
}) => PostModel(  date: date ?? this.date,
  localName: localName ?? this.localName,
  name: name ?? this.name,
  countryCode: countryCode ?? this.countryCode,
  fixed: fixed ?? this.fixed,
  global: global ?? this.global,
  counties: counties ?? this.counties,
  launchYear: launchYear ?? this.launchYear,
  type: type ?? this.type,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = date;
    map['localName'] = localName;
    map['name'] = name;
    map['countryCode'] = countryCode;
    map['fixed'] = fixed;
    map['global'] = global;
    map['counties'] = counties;
    map['launchYear'] = launchYear;
    map['type'] = type;
    return map;
  }

}