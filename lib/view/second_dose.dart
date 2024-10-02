import 'package:basics/color_const.dart';
import 'package:basics/constant/data_constant.dart';
import 'package:basics/model/TimeModel.dart';
import 'package:basics/string_const.dart';
import 'package:basics/valiidation_helper.dart';
import 'package:basics/widget_helper/rem_one.dart';
import 'package:basics/widget_helper/textbutton.dart';
import 'package:basics/widget_helper/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../date_utility.dart';

class SecondDose extends StatefulWidget {
  const SecondDose({super.key});

  @override
  State<SecondDose> createState() => _SecondDoseState();
}

class _SecondDoseState extends State<SecondDose> {
  var reminderType = 1;
  List<TimeModel> timerList = [];
  final formKey = GlobalKey<FormState>();
  // TextEditingController medicineNameCont = TextEditingController();
  // TextEditingController instructionsCont = TextEditingController();
  // TextEditingController medicineTypeCont = TextEditingController();
  // TextEditingController qtyCont = TextEditingController();
  // TextEditingController stockCont = TextEditingController();
  TextEditingController reminderTimeCont = TextEditingController();
  // TextEditingController startDateCont = TextEditingController();
  // TextEditingController endDateCont = TextEditingController();
  // TextEditingController medicineUnitCont = TextEditingController();

  var intervalCount = 0;
  TextEditingController medicineTimeCont = TextEditingController();
  TextEditingController periodCont = TextEditingController();
  TextEditingController frequencyCont = TextEditingController();

  String name = "";
  int slot = 1;

  List<String> intervalList = [];
  List<TimeModel> medicineTimerList = [];


  var prescriptionId = "";

  // Medicines? slotDetails;

  List<String> activeTimeList = [];

  String medicineTypeUnit = "";

  final GlobalKey secondComponentKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: Row(children: [

                Radio(
                    value: 1,
                    groupValue: reminderType,
                    onChanged: (int? newValue) {
                      reminderType = newValue!;
                      setState(() {});
                    }),
                getTxtColor(
                    msg: "Frequency",
                    txtColor: ColorConst.greyColor5F799F),
                Radio(
                    value: 2,
                    groupValue: reminderType,
                    onChanged: (newValue) {
                      reminderType = newValue!;
                      setState(() {});
                    }),
                getTxtColor(
                    msg: "Add Time",
                    txtColor: ColorConst.greyColor5F799F),
              ]),
            ),
            if (reminderType == 1)
              SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getTxtBlackColor(
                            msg: "Reminder times",
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                        // Container(
                        //   key: secondComponentKey,
                        //   child:  btnCorner("Tap", (){
                        //     showCustomBottomSheet(context, secondComponentKey,
                        //         "Select Frequency",
                        //         medicineFrequency,
                        //             (String selected,
                        //             int index, int count) {
                        //           Get.back();
                        //           intervalCount = count;
                        //           frequencyCont.text =
                        //           "$count times in a day";
                        //           medicineTimeCont.text = "";
                        //           periodCont.text = "";
                        //           intervalList = [];
                        //           setState(() {});
                        //         }
                        //     );
                        //   }),
                        // ),




                        const SizedBox(height: 5),
                        starText("Frequency"),


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
                                    medicineTimeCont.text = "";
                                    periodCont.text = "";
                                    // intervalList = [];
                                    setState(() {});
                                  }
                              );
                            },
                            validate: (value) =>
                                ValidationHelper.empty(
                                    value,
                                    "Frequency Required")),
                        const SizedBox(height: 20),

                        // getTxtColor(
                        //     msg: "Enter Time For First Dose",
                        //     fontWeight: FontWeight.w400,
                        //     txtColor: ColorConst.grey),





                        for(int i = 0;i<intervalCount;i++)
                          SizedBox(
                            height: 40,
                            width: double.infinity,
                            child:Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                      flex: 2,
                                      child: edtRectField(
                                          hint: "Select Time",
                                          control: medicineTimeCont,
                                          isReadOnly: true,
                                          onTap: () {
                                            if (frequencyCont
                                                .text.isEmpty) {
                                              getSnackbar(
                                                  title: StringConst
                                                      .error,
                                                  subTitle:
                                                  "Please select frequency",
                                                  isSuccess: false);
                                              return;
                                            }
                                            displayTimePicker((
                                                String time,
                                                String format,
                                                DateTime selectedDateTime) {
                                              medicineTimeCont
                                                  .text = time;
                                              periodCont.text =
                                                  format;
                                              // DateUtility.getIntervalLatest(
                                              //     selectedDateTime,
                                              //     intervalCount);
                                              intervalList =
                                                  DateUtility
                                                      .getIntervalLatest(
                                                      selectedDateTime,
                                                      intervalCount);
                                              setState(() {});
                                            });
                                          })),
                                  const SizedBox(width: 6),
                                  Flexible(
                                      flex: 2,
                                      child: edtRectField(
                                          hint: "Select Time",
                                          control: periodCont,
                                          isReadOnly: true,
                                          onTap: () {
                                            if (frequencyCont
                                                .text.isEmpty) {
                                              getSnackbar(
                                                  title: StringConst
                                                      .error,
                                                  subTitle:
                                                  "Please select frequency",
                                                  isSuccess: false);
                                              return;
                                            }
                                            displayTimePicker((
                                                String time,
                                                String format,
                                                DateTime selectedDateTime) {
                                              medicineTimeCont
                                                  .text = time;
                                              periodCont.text =
                                                  format;
                                              DateUtility.getIntervalLatest(
                                                  selectedDateTime,
                                                  intervalCount);
                                              print("$time $format, $selectedDateTime");
                                              intervalList =
                                                  DateUtility
                                                      .getIntervalLatest(
                                                      selectedDateTime,
                                                      intervalCount);
                                              setState(() {});
                                            });
                                          }))
                                ])
                            ,
                          ),

                        // if (intervalList.isNotEmpty)
                        //   const SizedBox(height: 20),
                        // if (intervalList.isNotEmpty)
                        //   getTxtColor(
                        //       msg: "Frequency Will Be",
                        //       fontWeight: FontWeight.w400,
                        //       txtColor: ColorConst.grey),
                        const SizedBox(height: 8),
                        // btnCancelCorner(intervalList[i], (bool isCancelClick) {
                        //   if(isCancelClick){
                        //     intervalList.removeAt(i);
                        //     setState(() {});
                        //   }
                        // }),
                        // Wrap(spacing: 8.0,
                        //     runSpacing: 8.0,
                        //     children: [
                        //       for (int i = 0; i <
                        //           intervalList.length; i++)
                        //         btnCorner(
                        //             intervalList[i], () {}),
                        //     ]),

                        const SizedBox(height: 20),



                      ])),

          ],
        ),
      ),
    );
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
                                        onTap: () => selectedIndex = index,
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
                                  onTap(
                                      frequencyCustomCont.text.toString(),
                                      selectedIndex,
                                      int.tryParse(frequencyCustomCont.text.toString()) ?? selectedIndex);
                                }
                              }),

                              const SizedBox(height: 20)
                            ]),
                      ))),
            );
          });
        }));


  }




  showReminderBottomSheet(Function onTap) {
    var intervalCount = 0;
    TextEditingController medicineTimeCont = TextEditingController();
    TextEditingController periodCont = TextEditingController();
    TextEditingController frequencyCont = TextEditingController();
    if (reminderType == 1 && intervalList.isNotEmpty) {
      frequencyCont.text =
      intervalList.isEmpty ? "" : "${intervalList.length} times in a day";
      medicineTimeCont.text =
      intervalList.isEmpty ? "" : "${getFirstFiveChars(intervalList.first)}";
      periodCont.text =
      intervalList.isEmpty ? "" : "${getLastTwoChars(intervalList.first)}";
    }
    return Get.bottomSheet(
        isDismissible: false,
        StatefulBuilder(builder: (context, setState) {
          return Container(
              decoration: const BoxDecoration(
                  color: ColorConst.whiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0))),
              child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            getTxtBlackColor(
                                msg: "Reminder times",
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                            Row(children: [
                              Radio(
                                  value: 1,
                                  groupValue: reminderType,
                                  onChanged: (int? newValue) {
                                    reminderType = newValue!;
                                    setState(() {});
                                  }),
                              getTxtColor(
                                  msg: "Frequency",
                                  txtColor: ColorConst.greyColor5F799F),
                              Radio(
                                  value: 2,
                                  groupValue: reminderType,
                                  onChanged: (newValue) {
                                    reminderType = newValue!;
                                    setState(() {});
                                  }),
                              getTxtColor(
                                  msg: "Add Time",
                                  txtColor: ColorConst.greyColor5F799F),
                            ]),
                            if (reminderType == 1)
                              SingleChildScrollView(
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        const SizedBox(height: 5),
                                        starText("Frequency"),
                                        edtRectField(
                                            hint: "Select Frequency",
                                            filledColor: ColorConst.greyColor,
                                            focusBorderColor: ColorConst
                                                .appColor,
                                            control: frequencyCont,
                                            isReadOnly: true,
                                            onTap: () {
                                              selectMedicineBottomSheet(
                                                  "Select Frequency",
                                                  medicineFrequency,
                                                      (String selected,
                                                      int index, int count) {
                                                    Get.back();
                                                    intervalCount = count;
                                                    frequencyCont.text =
                                                    "$count times in a day";
                                                    medicineTimeCont.text = "";
                                                    periodCont.text = "";
                                                    intervalList = [];
                                                    setState(() {});
                                                  });
                                            },
                                            validate: (value) =>
                                                ValidationHelper.empty(
                                                    value,
                                                    "Frequency Required")),
                                        const SizedBox(height: 20),

                                        getTxtColor(
                                            msg: "Enter Time For First Dose",
                                            fontWeight: FontWeight.w400,
                                            txtColor: ColorConst.grey),
                                        SizedBox(
                                            height: 40,
                                            width: double.infinity,
                                            child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                      flex: 2,
                                                      child: edtRectField(
                                                          hint: "Select Time",
                                                          control: medicineTimeCont,
                                                          isReadOnly: true,
                                                          onTap: () {
                                                            if (frequencyCont
                                                                .text.isEmpty) {
                                                              getSnackbar(
                                                                  title: StringConst
                                                                      .error,
                                                                  subTitle:
                                                                  "Please select frequency",
                                                                  isSuccess: false);
                                                              return;
                                                            }
                                                            displayTimePicker((
                                                                String time,
                                                                String format,
                                                                DateTime selectedDateTime) {
                                                              medicineTimeCont
                                                                  .text = time;
                                                              periodCont.text =
                                                                  format;
                                                              // DateUtility.getIntervalLatest(
                                                              //     selectedDateTime,
                                                              //     intervalCount);
                                                              intervalList =
                                                                  DateUtility
                                                                      .getIntervalLatest(
                                                                      selectedDateTime,
                                                                      intervalCount);
                                                              setState(() {});
                                                            });
                                                          })),
                                                  const SizedBox(width: 6),
                                                  Flexible(
                                                      flex: 2,
                                                      child: edtRectField(
                                                          hint: "Select Time",
                                                          control: periodCont,
                                                          isReadOnly: true,
                                                          onTap: () {
                                                            if (frequencyCont
                                                                .text.isEmpty) {
                                                              getSnackbar(
                                                                  title: StringConst
                                                                      .error,
                                                                  subTitle:
                                                                  "Please select frequency",
                                                                  isSuccess: false);
                                                              return;
                                                            }
                                                            displayTimePicker((
                                                                String time,
                                                                String format,
                                                                DateTime selectedDateTime) {
                                                              medicineTimeCont
                                                                  .text = time;
                                                              periodCont.text =
                                                                  format;
                                                              DateUtility.getIntervalLatest(
                                                                  selectedDateTime,
                                                                  intervalCount);
                                                              print("$time $format, $selectedDateTime");
                                                              intervalList =
                                                                  DateUtility
                                                                      .getIntervalLatest(
                                                                      selectedDateTime,
                                                                      intervalCount);
                                                              setState(() {});
                                                            });
                                                          }))
                                                ])),
                                        if (intervalList.isNotEmpty)
                                          const SizedBox(height: 20),
                                        if (intervalList.isNotEmpty)
                                          getTxtColor(
                                              msg: "Frequency Will Be",
                                              fontWeight: FontWeight.w400,
                                              txtColor: ColorConst.grey),
                                        const SizedBox(height: 8),
                                        // btnCancelCorner(intervalList[i], (bool isCancelClick) {
                                        //   if(isCancelClick){
                                        //     intervalList.removeAt(i);
                                        //     setState(() {});
                                        //   }
                                        // }),
                                        Wrap(spacing: 8.0,
                                            runSpacing: 8.0,
                                            children: [
                                              for (int i = 0; i <
                                                  intervalList.length; i++)
                                                btnCorner(
                                                    intervalList[i], () {}),
                                            ])
                                      ])),

                            const SizedBox(height: 20),
                            IconButton(onPressed: (){

                            }, icon: Icon(Icons.add)),
                          ]))));
        }));
  }
  String? getFirstFiveChars(String? str) {
    if (str != null && str.length >= 5) {
      return str.substring(0, 5);
    } else {
      return str;
    }
  }

  String? getLastTwoChars(String? str) {
    if (str != null && str.length >= 2) {
      return str.substring(str.length - 2);
    } else {
      return str;
    }
  }
  Future displayTimePicker(
      Function(String time, String formate, DateTime selectedDateTime)
      selectedTimeClick) async
  {
    TimeOfDay now = TimeOfDay.now();
    TimeOfDay adjustedTime = TimeOfDay(hour: now.hour,minute: 00);
    await showTimePicker(context: context, initialTime:adjustedTime)
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

  selectMedicineBottomSheet(String title, List<String> list,
      Function(String selectedValue, int selectedIndex, int count) onTap, {String hint = "Times in a day", TextInputType keyboardType = TextInputType.number})
  {
    TextEditingController frequencyCustomCont = TextEditingController();
    frequencyCustomCont.text = '';
    int selectedIndex = 0;
    String? selectedValue = "";
    GlobalKey<FormState>? bottomSheetFormKey = GlobalKey<FormState>();


    Get.bottomSheet(StatefulBuilder(builder: (context, setState) {

      return Container(

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
                                onTap: () => selectedIndex = index,
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
                          onTap(
                              frequencyCustomCont.text.toString(),
                              selectedIndex,
                              int.tryParse(frequencyCustomCont.text.toString()) ?? selectedIndex);
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
              )));
    }));
  }
}
