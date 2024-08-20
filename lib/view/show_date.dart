import 'dart:convert';
import 'package:basics/model/dateModel.dart';
import 'package:basics/widget_helper/textbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ShowDate extends StatefulWidget {
  const ShowDate({super.key});

  @override
  State<ShowDate> createState() => _ShowDateState();
}

class _ShowDateState extends State<ShowDate> {
  List<DateModel>? _dateModels;

  DateTime today = DateTime(2024, 07, 30);

  @override
  void initState() {
    super.initState();
    readLocalJson();

  }

  var monthList = [];
  var twomonthList=[];
  var thisWeekList=[];
  var lastweekList = [];
  var thirdweekList = [];
  var fourthdweekList = [];



  void categorizeDate(int dayDifference, String date, int greaterThan, int lessThan, List<dynamic> particularList) {
    if (dayDifference > greaterThan && dayDifference <= lessThan) {
      particularList.add(date);
    }
  }

  readLocalJson() async {
    final jsonString = await rootBundle.loadString("assets/json/date.json");
    final jsonList = jsonDecode(jsonString) as List;
    for (var i = 0; i < jsonList.length; i++) {
      // final dateModel = DateModel.fromJson(jsonList[i]);
      final dateFormat = DateFormat('yyyy-MM-dd');
      final dateModel =dateFormat.format(DateTime.parse(DateModel.fromJson(jsonList[i]).date ?? ''));
      final dayDifference = today.difference(DateTime.parse(dateModel)).inDays;
      categorizeDate(dayDifference, dateModel, 9, 17, lastweekList);
      categorizeDate(dayDifference, dateModel, 17, 25, thirdweekList);
      categorizeDate(dayDifference, dateModel, 25, 33, fourthdweekList);
      categorizeDate(dayDifference, dateModel, 33, 57, monthList);
      categorizeDate(dayDifference, dateModel, 57, 87, twomonthList);
    }


    final dateModels =
        jsonList.map((json) => DateModel.fromJson(json)).toList();

    setState(() {
      _dateModels = dateModels;
    });

    // return _dateModels;
  }

  int count = 0;

  @override
  Widget build(BuildContext context) {
    DateTime yesturday = today.subtract(Duration(days: 1));
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [


              SizedBox(

                height: 30,
              ),
              // Text(monthList[1]),
              SizedBox(
                  // height: 500,
                  child: _dateModels == null
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          // itemCount: _dateModels!.length,
                          itemCount: 9,
                          itemBuilder: (context, index) {

                            return Column(
                              children: [

                                if (today.toString() ==
                                    DateTime.parse(_dateModels![index].date!)
                                        .toString())
                                  getTxtBlackColor(msg: "Today"),
                                //Yesturdaay
                                if (yesturday.toString() == DateTime.parse(_dateModels![index].date!).toString())
                                  getTxtBlackColor(msg: "yes"),

                                if (today.difference(DateTime.parse(_dateModels![index].date!)).inDays <= 9
                                    && today.difference(DateTime.parse(_dateModels![index].date!)).inDays > 2)
                                  getTxtBlackColor(
                                      msg: DateFormat.EEEE().format(
                                          DateTime.parse(
                                              _dateModels![index].date!))),



                                Card(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      getTxtBlackColor(msg: "index ${index}"),
                                      getTxtBlackColor(
                                          msg: today.toString() ==
                                                  DateTime.parse(_dateModels![index].date!)
                                                      .toString()? "Today" : yesturday.toString() == DateTime.parse(_dateModels![index].date!).toString()
                                                  ? "Yesterday"
                                                  : today.difference(DateTime.parse(_dateModels![index].date!)).inDays <= 9
                                              && today.difference(DateTime.parse(_dateModels![index].date!)).inDays > 2
                                                      ? DateFormat.EEEE().format(DateTime.parse(_dateModels![index].date!))
                                                      : "",

                                          fontSize: 18),
                                      getTxtBlackColor(
                                          msg: _dateModels![index].date!,
                                          fontSize: 20)
                                    ],
                                  ),
                                ),
                              ],
                            );
                          })),
              CustomListSection(
                sectionTitle: "Last week",
                sectionSubTitle: "",
                itemList: lastweekList,
              ),

              CustomListSection(
                sectionTitle: "Third week",
                sectionSubTitle: "",
                itemList: thirdweekList,
              ),
              CustomListSection(
                sectionTitle: "Fourth week",
                sectionSubTitle: "",
                itemList: fourthdweekList,
              ),
              CustomListSection(
                sectionTitle: "One Month Ago",
                sectionSubTitle: "",
                itemList: monthList,
              ),
              CustomListSection(
                sectionTitle: "Two Month Ago",
                sectionSubTitle: "",
                itemList: twomonthList,
              ),
              CustomListSection(
                sectionTitle: "Today",
                sectionSubTitle: "",
                itemList: _dateModels!.map((dateModel) => dateModel.date!).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
