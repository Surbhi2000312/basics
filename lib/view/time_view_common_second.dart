import 'dart:math';

import 'package:basics/color_const.dart';
import 'package:basics/constant/data_constant.dart';
import 'package:basics/model/TimeModel.dart';
import 'package:basics/valiidation_helper.dart';
import 'package:basics/widget_helper/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../widget_helper/textbutton.dart';

class TimeViewCommonSecond extends StatefulWidget {
  const TimeViewCommonSecond({super.key});

  @override
  State<TimeViewCommonSecond> createState() => _TimeViewCommonSecondState();
}

class _TimeViewCommonSecondState extends State<TimeViewCommonSecond> {
  List<TimeModel> timerList = [];
  var intervalCount = 0;
  TextEditingController medicineTimeCont = TextEditingController();
  TextEditingController periodCont = TextEditingController();
  TextEditingController frequencyCont = TextEditingController();
  final GlobalKey secondComponentKey = GlobalKey();


  @override
  void initState() {
    // TODO: implement initState
    // for(int i = 0;i<=2;i++)
    //   {
    //     int uniqueId = Random().nextInt(1000000);
    //     timerList.add(TimeModel(uniqueId: uniqueId));
    //   }
    int uniqueId = Random().nextInt(1000000);
    timerList.add(TimeModel(uniqueId: uniqueId));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [




            SizedBox(height: 60,),
            getTxtColor(
                msg: "Frequency",
                txtColor: ColorConst.greyColor5F799F),
            edtRectField(
                key:  secondComponentKey,
                hint: "Select Frequency",
                filledColor: ColorConst.greyColor,
                focusBorderColor: ColorConst
                    .appColor,
                control: frequencyCont,
                isReadOnly: true,
                onTap: () {
                  showCustomBottomSheet(context, secondComponentKey,
                      "Select Frequency",
                      medicineFrequency,
                          (String selected,
                          int index, int count) {
                        Get.back();
                        intervalCount = count;
                        frequencyCont.text =
                        "$count times in a day";
                        print("count=>>>>> $count");
                        medicineTimeCont.text = "";
                        periodCont.text = "";
                        setState(() {
                          for(int i = 1;i<=intervalCount;i++)
                          {
                            int uniqueId = Random().nextInt(1000000);
                            timerList.add(TimeModel(uniqueId: uniqueId));
                          }
                        });
                        // intervalList = [];
                      }
                  );
                },
                validate: (value) =>
                    ValidationHelper.empty(
                        value,
                        "Frequency Required")),
            const SizedBox(height: 20),
            // SizedBox(child: r(intervalCount),),
            Text("$intervalCount"),
            Text("Reminder"),


            for (int i = 0; i == 0; i++)
              getTimerOnce(timerList[0], () {
                setState(() {});
              }),

            for (int i = 1; i < timerList.length; i++)
              getTimerList(timerList[i], () {
                setState(() {});
              }),
            // TextButton(
            //   onPressed: () {
            //
            //     setState(() {
            //       // Assign a unique ID using a random number generator or use a counter
            //       int uniqueId = Random().nextInt(1000000);
            //       timerList.add(TimeModel(uniqueId: uniqueId));
            //
            //     });
            //   },
            //   child: getTxtColor(
            //       msg: "+ Add More Time",
            //       txtColor: Colors.black,
            //       fontWeight: FontWeight.w500,
            //       fontSize: 15),
            // ),
          ],
        ),
      ),

    );
  }



  Widget getTimerList(TimeModel item, Function onTap){
    TextEditingController medicineTimeCont = TextEditingController();
    TextEditingController periodCont = TextEditingController();

    if (item.time?.isEmpty == false && item.time != "null") {
      medicineTimeCont.text = "${item.time}";
      periodCont.text = "${item.timeFormat}";
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        height: 40,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 3,
              child: edtRectField(
                hint: "Select Time",
                control: medicineTimeCont,
                isReadOnly: true,
                onTap: () {
                  displayTimePicker((String time, String format, DateTime selectedDateTime) {
                    DateTime now = DateTime.now();

                    setState(() {
                      item.time = time;
                      item.timeFormat = format;
                    });

                    Duration difference = selectedDateTime.difference(now);
                    // _testNotification(item.uniqueId!, difference.inSeconds);
                    onTap();
                  });
                },
              ),
            ),
            const SizedBox(width: 6),
            Flexible(
              flex: 2,
              child: edtRectField(
                control: periodCont,
                hint: "Time",
                isReadOnly: true,
                onTap: () {
                  displayTimePicker((String time, String format, DateTime selectedDateTime) {
                    setState(() {
                      item.time = time;
                      item.timeFormat = format;
                    });
                    onTap();
                  });
                },
              ),
            ),
            Flexible(
              flex: 1,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    timerList.removeWhere((t) => t.uniqueId == item.uniqueId);
                    // _notificationService.cancelNotification(item.uniqueId!);
                  });
                  onTap();
                },
                icon: const Icon(Icons.clear),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget getTimerOnce(TimeModel item, Function onTap) {
    TextEditingController medicineTimeCont = TextEditingController();
    TextEditingController periodCont = TextEditingController();

    if (item.time?.isEmpty == false && item.time != "null") {
      medicineTimeCont.text = "${item.time}";
      periodCont.text = "${item.timeFormat}";
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        height: 40,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 3,
              child: edtRectField(
                hint: "Select Time",
                control: medicineTimeCont,
                isReadOnly: true,
                onTap: () {
                  displayTimePicker((String time, String format, DateTime selectedDateTime) {
                    DateTime now = DateTime.now();

                    setState(() {
                      item.time = time;
                      item.timeFormat = format;
                    });

                    Duration difference = selectedDateTime.difference(now);
                    // _testNotification(item.uniqueId!, difference.inSeconds);
                    onTap();
                  });
                },
              ),
            ),
            const SizedBox(width: 6),
            Flexible(
              flex: 2,
              child: edtRectField(
                control: periodCont,
                hint: "Time",
                isReadOnly: true,
                onTap: () {
                  displayTimePicker((String time, String format, DateTime selectedDateTime) {
                    setState(() {
                      item.time = time;
                      item.timeFormat = format;
                    });
                    onTap();
                  });
                },
              ),
            ),
            Flexible(
              flex: 1,
              child: IconButton(
                onPressed: () {


                },
                icon: Text(""),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Future displayTimePicker(Function(String time, String format, DateTime selectedDateTime) selectedTimeClick) async
  {
    TimeOfDay now = TimeOfDay.now();
    TimeOfDay adjustedTime = TimeOfDay(hour: now.hour, minute: now.minute);
    await showTimePicker(context: context, initialTime: adjustedTime)
        .then((selectedTime) {
      if (selectedTime != null) {
        DateTime now = DateTime.now();
        DateTime selectedDateTime = DateTime(now.year, now.month, now.day,
            selectedTime.hour, selectedTime.minute);
        String formattedTime = DateFormat('hh:mm').format(selectedDateTime);
        final period = selectedTime.period == DayPeriod.am ? 'AM' : 'PM';
        selectedTimeClick(formattedTime, period, selectedDateTime);
      }
    });
  }
  void showCustomBottomSheet(BuildContext context, GlobalKey key,
      String title, List<String> list,
      Function(String selectedValue, int selectedIndex, int count) onTap,
      {String hint = "Times in a day", TextInputType keyboardType = TextInputType.number}
      )
  {
    TextEditingController frequencyCustomCont = TextEditingController();
    frequencyCustomCont.text = '';
    int selectedIndex = 0;
    String? selectedValue = "";
    GlobalKey<FormState>? bottomSheetFormKey = GlobalKey<FormState>();

    final RenderBox? renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) {
      // Handle the case where renderBox is null
      return;
    }

    final componentPosition = renderBox.localToGlobal(Offset.zero);

    double? screenHeight = MediaQuery.of(context).size.height;
    if (screenHeight == null) {
      // Handle the case where screenHeight is null
      return;
    }

    double sheetHeight = screenHeight - componentPosition.dy;
    if (sheetHeight < 0) {
      // Handle the case where sheetHeight is negative
      sheetHeight = 0;
    } else if (sheetHeight > screenHeight) {
      // Handle the case where sheetHeight is greater than the height of the screen
      sheetHeight = screenHeight;
    }

    Get.bottomSheet(
        isScrollControlled: true,
        StatefulBuilder(builder:  (context, setState){
          // isScrollControlled: true;
          return LayoutBuilder(builder:  (context, constraints){
            // constraints: BoxConstraints(maxHeight: 500);
            return ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 600),
              child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  child: Container(
                      margin: const EdgeInsets.only(top: 10.0, left: 20, right: 10),
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              getTxtBlackColor(
                                  msg: title, fontSize: 19, fontWeight: FontWeight.w500),
                              const SizedBox(height: 10),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: list.length ?? 0,
                                  itemBuilder: (BuildContext context, int index) {
                                    String item = list[index];
                                    return InkWell(
                                        onTap: () {
                                          if (item == "Custom") {
                                            frequencyCustomCont.text = "";
                                            setState(() {
                                              selectedIndex = index;
                                              selectedValue = "";
                                            });
                                          } else {
                                            setState(() {
                                              selectedIndex = index;
                                              selectedValue = item;
                                            });
                                          }
                                        },
                                        child: Row(children: [
                                          Radio(
                                              value: item,
                                              groupValue: selectedValue,
                                              onChanged: (String? value) {
                                                selectedIndex = index;
                                                selectedValue = value;
                                                setState(() {});
                                              }),
                                          getTxtBlackColor(msg: item)
                                        ]));
                                  }),
                              Form(
                                key: bottomSheetFormKey,
                                child: Container(
                                  margin: const EdgeInsets.only(left: 20, right: 30),
                                  child: edtRectField(
                                      hint: hint,
                                      filledColor: ColorConst.greyColor,
                                      focusBorderColor: ColorConst.appColor,
                                      control: frequencyCustomCont,
                                      keyboardType: keyboardType,
                                      validate: (value) => ValidationHelper.empty(
                                          value, "$hint Required")),
                                ),
                              ),
                              const SizedBox(height: 10),

                              btnCorner("OK", (){
                                final form = bottomSheetFormKey?.currentState;
                                print( "msg");
                                if (list[selectedIndex] != "Custom") {
                                  onTap(
                                      selectedValue!, selectedIndex, selectedIndex + 1);
                                } else if (form?.validate() == true) {
                                  form?.save();
                                  int customCount;
                                  try {
                                    customCount = int.parse(frequencyCustomCont.text.toString());
                                  } catch (e) {
                                    customCount = 1; // default value if parsing fails
                                  }
                                  onTap(
                                      frequencyCustomCont.text.toString(),
                                      selectedIndex,
                                      customCount);
                                }
                              }),
                              // btnProgress("Ok", bgColor: ColorConst.secondaryColor,
                              //     onTap: (startLoading, stopLoading, btnState) async {
                              //       if (btnState == ButtonState.idle) {
                              //
                              //         final form = bottomSheetFormKey?.currentState;
                              //         print( "msg");
                              //         if (list[selectedIndex] != "Custom") {
                              //           onTap(
                              //               selectedValue!, selectedIndex, selectedIndex + 1);
                              //         } else if (form?.validate() == true) {
                              //           form?.save();
                              //           onTap(
                              //               frequencyCustomCont.text.toString(),
                              //               selectedIndex,
                              //               int.tryParse(frequencyCustomCont.text.toString()) ?? selectedIndex);
                              //         }
                              //       }
                              //     }),
                              const SizedBox(height: 20)
                            ]),
                      ))),
            );
          });
        }));


  }
}
