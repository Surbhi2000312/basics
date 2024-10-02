import 'dart:convert';
import 'dart:math';

import 'package:basics/crudForm/form_screen.dart';
import 'package:basics/employee/employee_list_screen.dart';
import 'package:basics/rest_api_crud/employee_form.dart';
import 'package:basics/rest_api_crud/employee_screen.dart';
import 'package:basics/employee/employee_service.dart';
import 'package:basics/restapi_dio/dio_screen.dart';
import 'package:basics/services/notification_helper.dart';
import 'package:basics/services/notification_service.dart';
import 'package:basics/view/TimeView.dart';
import 'package:basics/view/bottom_bar.dart';
import 'package:basics/view/dummy.dart';


import 'package:basics/view/ram.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:basics/view/show_date.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:basics/pages/PostModel.dart';
import 'package:basics/pages/screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'view/date_one.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationService notificationService = NotificationService();
  await notificationService.initNotification();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context){
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: BottomBar(),
      home: DioScreen(),
    );

  }
}









class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // DateTime now = DateTime.now();
  DateTime today = DateTime(2020,12,25);
  PostModel postModel = PostModel();
  // List<DateModel> dateList = [];
  List<PostModel> postList = [];



  Future<List<PostModel>> getDateApi () async{
    final response = await http.get(Uri.parse('https://date.nager.at/api/v2/publicholidays/2020/US'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map i in data){
        postList.add(PostModel.fromJson(i));
      }
      return postList;
    }else return postList;
  }

  Future<void> getListDateApi() async {
    final response = await http.get(Uri.parse('https://date.nager.at/api/v2/publicholidays/2020/US'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      postList = data.map((item) => PostModel.fromJson(item)).toList();
      setState(() {});
    } else {
      throw Exception('Failed to load data');
    }
  }



@override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    DateTime yesterday = today.subtract(Duration(days: 1));
    print("today: $today");
    print("yesterday : $yesterday");

    DateTime weeksago = today.subtract(Duration(days: 7));
    print("weeksago $weeksago");

    DateTime monthsago = new DateTime(today.year, today.month - 1, today.day);
    print("Monthsago $monthsago");

    DateTime twoMonthsago =  new DateTime(today.year, today.month - 2, today.day);
    print("TwoMonthsago $twoMonthsago");

    DateTime dummy = DateTime(2020,11,11);
    print("dummy $dummy");




    if (monthsago.isAfter(twoMonthsago) && monthsago.isBefore(today)) {
      print("true &&");
    } else if (today.isBefore(weeksago)) {
      print("Today is before weeks ago");
    } else {
      print("Today is equal to weeks ago");
    }

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

      body: FutureBuilder(
        future: getDateApi(),
        builder: (context, AsyncSnapshot<List<PostModel>> snapshot,){
          if(snapshot.hasData){

            return ListView.builder(
                itemCount: 13,
                itemBuilder: (context, index) {



                  return Card(
                    child: Column(
                      children: [

                          // if(today==DateTime.parse(snapshot.data![index].date!))
                          //   Text("Today"),
                          // if(DateTime.parse(snapshot.data![index].date!).day>21)
                          //   Text("3rd Week"),

                        Text(
                          today.difference(DateTime.parse(snapshot.data![index].date!)).inDays == 0
                              ? "Today"
                              : today.difference(DateTime.parse(snapshot.data![index].date!)).inDays == 1
                              ? "Yesterday"
                              : today.difference(DateTime.parse(snapshot.data![index].date!)).inDays <= 7
                              ? DateFormat.EEEE().format(DateTime.parse(snapshot.data![index].date!))
                              : today.difference(DateTime.parse(snapshot.data![index].date!)).inDays <= 14
                              ? "One week ago"
                              : today.difference(DateTime.parse(snapshot.data![index].date!)).inDays <= 21
                              ? "Two weeks ago"
                              : today.difference(DateTime.parse(snapshot.data![index].date!)).inDays <= 28
                              ? "Three weeks ago"
                              : today.difference(DateTime.parse(snapshot.data![index].date!)).inDays <= 30
                              ? "One month ago"
                              : today.difference(DateTime.parse(snapshot.data![index].date!)).inDays <= 60
                              ? "Two months ago"
                              : today.difference(DateTime.parse(snapshot.data![index].date!)).inDays <= 90
                              ? "Three months ago"
                              : "Other",
                        ),


                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Text(snapshot.data!index),
                              Text("Index: ${index+1}"),

                              Text(snapshot.data![index].date.toString()),
                            ],
                          )

                      ],
                    ),
                  );
                }
            );
          } else if (snapshot.hasError) {
            print("Error: ${snapshot.error}");

            return Text('Error: ${snapshot.error}');
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
