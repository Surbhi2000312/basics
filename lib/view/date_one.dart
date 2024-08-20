import 'package:basics/controller/dateController.dart';
import 'package:basics/model/dateModel.dart';
import 'package:basics/widget_helper/textbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class DateOne extends StatelessWidget {
  const DateOne({super.key});


  @override
  Widget build(BuildContext context) {
  print("------");
    final DateController dateController = Get.put(DateController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60),
            getTxtBlackColor(msg: "Today"),
            getTxtBlackColor(msg:dateController.currentDate),

            getTxtBlackColor(msg: "Yesterday"),
            getTxtBlackColor(msg:dateController.yester_Day),

            SizedBox(height: 60,),
            getTxtBlackColor(msg: "This Week"),
            SizedBox(height: 10,),
            SizedBox(
              child:
                  Obx((){

                    return dateController.thisWeekList==null?
                    Center(child: CircularProgressIndicator(),):
                      ListView.builder(
                       
                      padding: EdgeInsets.only(bottom: 30),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: dateController.thisWeekList.length,

                      // itemCount: 1,
                        itemBuilder: (context,index){
                          // print("dateController.thisWeekList.length ${dateController.thisWeekList.length}");
                        return Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            getTxtBlackColor(msg:DateFormat.EEEE().format(DateTime.parse(dateController.thisWeekList[index]))),
                            getTxtBlackColor(msg: dateController.thisWeekList[index]),

                          ],
                        );
                        // return Text(dateController.dateModels[index].date.toString());
                        });
                  }),

            ),

            SizedBox(
              child:  CustomListSection(sectionTitle: "Last", sectionSubTitle: "Week", itemList: dateController.lastweekList ),
            ),
            SizedBox(
              child: CustomListSection(sectionTitle: "last", sectionSubTitle: "month", itemList: dateController.monthList ),
            ),


          ],
        ),
      ),
    );
  }
}
