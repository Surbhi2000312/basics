import 'package:basics/color_const.dart';
import 'package:basics/date_utility.dart';
import 'package:basics/widget_helper/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
class Normal extends StatefulWidget {
  const Normal({super.key});

  @override
  State<Normal> createState() => _NormalState();
}

class _NormalState extends State<Normal> {
  final _formKey = GlobalKey<FormState>();

  late var intervalList=[];
  // final _forKey = GlobalKey<FormState>();
  TextEditingController zero= TextEditingController();
  TextEditingController one= TextEditingController();
  TextEditingController two= TextEditingController();
  TextEditingController three= TextEditingController();


  TextEditingController frequencyCont= TextEditingController();
  TextEditingController timeCont= TextEditingController();
  TextEditingController periodCont= TextEditingController();
  
  DateTime now = DateTime.now();
  final DateFormat timeFormat = DateFormat('hh:mm a');

  // DateTime startTime = actualIn24hr;
  display(){

  }

  @override
  Widget build(BuildContext context) {

    print("timeFormat.format(time)");
    print(timeFormat.format(now));
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [

            // SizedBox(height: 120,),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: edtRectField(
                    control: frequencyCont,
                    hint:"type frequency",
                    filledColor: ColorConst.greyColor,
                    focusBorderColor: ColorConst.appColor,
                    keyboardType: TextInputType.number,
                    isReadOnly: false,
                    onTap: (){
                      print("frequency Cont");
                      print(frequencyCont.text);
                    },

                  ),
                ),
                Flexible(
                  flex: 1,
                  child: edtRectField(
                    control:timeCont,
                    hint:"select time",
                      filledColor: ColorConst.greyColor,
                      focusBorderColor: ColorConst.appColor,
                      keyboardType: TextInputType.text,
                    onTap: (){
                       var time = showTimePicker
                         (context: context,
                           initialTime: TimeOfDay(hour: 6, minute: 6),)
                           .then((selectedTime){
                             if(selectedTime != null){
                               // frequency.text =selectedTime.format(context);
                               setState(() {
                                 DateTime selectedDateTime = DateTime(now.year, now.month, now.day,
                                     selectedTime.hour, selectedTime.minute);
                                 print("");
                                 print("");
                                 print("------------");
                                 print("selectedTime");
                                 print(selectedTime);
                                 print("------------");
                                 String formattedTime = DateFormat('hh:mm').format(selectedDateTime);
                                 timeCont.text = formattedTime;
                                 print("formattedTime");
                                 print(formattedTime);
                                 print("------------");
                                 final period = selectedTime.period == DayPeriod.am ? 'AM' : 'PM';
                                 periodCont.text = period;
                                 DateTime startTime = selectedDateTime;
                                 print("startTime");
                                 print(startTime);
                                 print("------------");
                                 DateTime endTime = selectedDateTime;
                                 print("endTime");
                                 print(endTime);
                                 print("------------");
                                 endTime = endTime.add(const Duration(days: 1));
                                 print("endTime.add(const Duration(days: 1))");
                                 print(endTime);
                                 Duration totalDuration = endTime.difference(startTime);
                                 print("totalDuration = endTime.difference(startTime)");
                                 print(totalDuration);
                                 print("------------");
                                 int numberOfIntervals = int.parse(frequencyCont.text);
                                 Duration intervalDuration = totalDuration ~/ numberOfIntervals;
                                 print("intervalDuration ");
                                 print(intervalDuration);
                                 print("------------");
                                 DateTime currentTime = startTime;
                                 print("currentTime");
                                 print(currentTime);
                                 print("------------");
                                 List<String> finalIntervals = [];
                                 for (int i = 1; i <= numberOfIntervals; i++) {
                                   print( 'Interval $i Boundary: ${timeFormat.format(currentTime)}');
                                   finalIntervals.add(timeFormat.format(currentTime));
                                   currentTime = currentTime.add(intervalDuration);
                                 }

                                 print("");
                                 print("");
                               });
                             }

                       });

                    },

                  ),
                ),
                Flexible(
                  flex: 1,
                  child: edtRectField(
                    control: periodCont,
                    hint:"select frequency",
                    filledColor: ColorConst.greyColor,
                    focusBorderColor: ColorConst.appColor,
                    keyboardType: TextInputType.text,
                    onTap: (){
                      var time = showTimePicker
                        (context: context,
                        initialTime: TimeOfDay(hour: 6, minute: 6),)
                          .then((time){
                        if(time != null){
                          timeCont.text =time.format(context);
                        }
                      });

                    },

                  ),
                ),


              ],
            ), 
            SizedBox(height: 60,),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'example@example.com',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value){
                      String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regExp = RegExp(p);
                      if(value?.trim().isBlank == true){
                        return 'Enter some text';
                      }
                      else if(!regExp.hasMatch(value!)){
                        return 'Name must contain only letters and spaces';
                      }
                      return null;
                    },
                    controller: zero,
                  ),

                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'example.@example.com',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value){
                      String p = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                      RegExp regExp = RegExp(p);
                      if(value?.trim().isBlank == true ){
                        return 'Enter some text';
                      }
                      else if(!regExp.hasMatch(value!)){
                        return 'Name must contain only letters and spaces';
                      }
                      return null;
                    },
                    controller: one,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'at first any char but end with letter',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value){
                      String p = r'^.+[a-zA-Z]$';
                      RegExp regExp = RegExp(p);
                      if(value?.trim().isBlank == true ){
                        return 'Enter some text';
                      }
                      else if(!regExp.hasMatch(value!)){
                        return 'Name must contain only letters and spaces';
                      }
                      return null;
                    },
                    controller: two,
                  ),
                  TextFormField(

                    validator: (value){
                      String p = r'(^[a-zA-Z ]*$)';
                      RegExp regExp = RegExp(p);
                      if(value?.trim().isBlank == true ){
                        return 'Enter some text';
                      }
                      else if(!regExp.hasMatch(value!)){
                        return 'Name must contain only letters and spaces';
                      }
                      return null;
                    },
                    controller: three,
                  ),
                  ElevatedButton(onPressed: (){
                    if(_formKey.currentState!.validate()){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Processing Data")),
                      );
                    }
                    // print(dummy.text.toString());

                  }, child: Text("Save")),


                ],
              ),
            ),
        
          ],
        ),
      ),
    );
  }

}
