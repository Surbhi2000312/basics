import 'dart:convert';
import 'package:basics/model/dateModel.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateController extends GetxController {
  RxList dateModels = <DateModel>[].obs;
  RxBool isLoading = true.obs;
  RxList monthList = [].obs;
  RxList twomonthList=[].obs;
  RxList thisWeekList=[].obs;
  RxList lastweekList = [].obs;
  RxList thirdweekList = [].obs;
  RxList fourthdweekList = [].obs;
  var currentDate = "";
  var yester_Day = "";
  final today = DateTime(2024, 07, 30);



  @override
  void onInit() {
    super.onInit();
    readLocalJson();
    print(" adding => ${today.subtract(const Duration(days: 2))}");
  }
  final dateFormat = DateFormat('yyyy-MM-dd');
  // final dayFormat = DateFormat.EEEE() ;
  //
  void readLocalJson() async {
    try {
      final jsonString = await rootBundle.loadString("assets/json/date.json");
      final jsonList = jsonDecode(jsonString) as List;

      for(int i=0;i<jsonList.length;i++){


       final dateModels = dateFormat.format(DateTime.parse(DateModel.fromJson(jsonList[i]).date ?? ''));
       // var dateModelDay =dayFormat.format(DateTime.parse(DateModel.fromJson(jsonList[i]).date ?? ''));

       final date = DateTime.parse(dateModels);
       // final dateModels = dateFormat.format(date);
       //  dateModelDay = dayFormat.format(date);

       // print("Days => $dateModelDay");

        // dateModelDay = DateFormat.EEEE().format(DateTime.parse(_dateModels[index].date!));
       final dayDifference = today.difference(DateTime.parse(dateModels)).inDays;

       // if (dayDifference> 1 &&
       //     dayDifference <=8)
       // {
       //   // print(dateModel);
       //   //  thisWeekList.add(dateModelDay);
       //   thisWeekList.add(dateModels);
       // }
       categorizeDate(dayDifference, dateModels, 1, 8, thisWeekList);
       categorizeDate(dayDifference, dateModels, 9, 19, lastweekList);
       categorizeDate(dayDifference, dateModels, 30, 60, monthList);
       // categorizeDate(dayDifference, dateModels, 1, 8, thisWeekList);

        if(isToday(dateModels)){
          currentDate=dateModels.toString();
          // print("current Date $currentDate");
        }
        if(isYesterday(dateModels)){
          yester_Day=dateModels.toString();
          // print("yesterDay $yester_Day");
        }

       // categorizeDate(dayDifference, dateModels, 2, 8, thisWeekList);

      }

      final dateModelList = jsonList.map((json) => DateModel.fromJson(json)).toList();

      dateModels.value = dateModelList;



    } finally {
      isLoading(false);
    }
  }

  DateTime parseDate(String dateString) {
    return DateFormat('yyyy-MM-dd').parse(dateString);
  }

  bool isToday(String dateString) {
    // final today = DateTime.now();

    final parsedDate = parseDate(dateString);
    return today.year == parsedDate.year &&
        today.month == parsedDate.month &&
        today.day == parsedDate.day;
  }
  bool isYesterday(String dateString) {
    // final yesterday = DateTime.now().subtract(Duration(days: 1));
    final yesterday =  today.subtract(Duration(days: 1));
    final parsedDate = parseDate(dateString);
    return yesterday.year == parsedDate.year &&
        yesterday.month == parsedDate.month &&
        yesterday.day == parsedDate.day;
  }
  void categorizeDate(int dayDifference, String date, int greaterThan, int lessThan, List<dynamic> particularList) {
    // print("categorization");
    if (dayDifference > greaterThan && dayDifference <= lessThan) {
      particularList.add(date);
     // print(date);
    }
  }
}
