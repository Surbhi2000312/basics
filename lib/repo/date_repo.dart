import 'dart:convert';

import 'package:basics/model/dateModel.dart';
import 'package:flutter/services.dart';

class DateRepository {
  static List<DateModel>? _dateModels;

  static Future<void> init() async {
    final jsonString = await rootBundle.loadString("assets/json/date.json");
    final jsonList = jsonDecode(jsonString) as List;
    final dateModels = jsonList.map((json) => DateModel.fromJson(json)).toList();
    _dateModels = dateModels;
  }

  static List<DateModel>? get getDateList => _dateModels;
}