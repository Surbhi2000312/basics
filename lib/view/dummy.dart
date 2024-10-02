import 'package:basics/constant/data_constant.dart';
import 'package:basics/widget_helper/textbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget_helper/widget_helper.dart';

class Dummy extends StatefulWidget {
  const Dummy({super.key});

  @override
  State<Dummy> createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
  late int selectedRadio;
  var slot = 1;
  TextEditingController instructionsCont = TextEditingController();
  TextEditingController daysCont = TextEditingController();
  TextEditingController medicineTypeCont = TextEditingController();
  TextEditingController listCont = TextEditingController();

  String selectedValue = "";
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

// Changes the selected value on 'onChanged' click on each radio button
  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  List<int> list = [10, 22, 33, 42, 51];
 int sIndex=  0;
  String? sValue = "";


  r(){
    int a = 3;
    int b = 3;

    var x = List.generate(a, (i) => List.generate(b, (j) => j));
    print(x);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SingleChildScrollView(
        child: Column(

          children: [
            SizedBox(height: 120,),
            
            IconButton(onPressed: (){
              r();
            }, icon: Icon(Icons.rectangle,size: 100,)),








            SizedBox(height: 120,),
            SizedBox(
              // height: 500,
              child: ListView.builder(
                  // itemCount: 3,
                  itemCount: list.length ?? 0,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context ,int index){
                    int item = list[index];
                    return  InkWell(
                      onTap: (){
                        sIndex = index;

                      },
                      child: Row(
                        children: [
                          Radio(
                            value: item,
                            groupValue: selectedRadio,
                            activeColor: Colors.green,
                            onChanged: (val) {
                              print("Radio $val");
                              setSelectedRadio(val!);
                              sIndex=index;
                              sValue=val.toString();
                            },
                          ),
                        getTxtBlackColor(msg: item.toString())
                        ],
                      ),
                    );
                  }
              ),
            ),
            SizedBox(
              child: getTxtBlackColor(msg: sIndex.toString()),
            ),
            SizedBox(
              child: getTxtBlackColor(msg: sValue.toString()),
            ),

            SizedBox(
              child: Container(
                color: Colors.red,
                child: ListView(
                shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const SizedBox(height: 120),

                    // Use the radioList function with myList
                    radioList(
                      title: "Choose an Option",
                      list: myList,
                      selectedValue: selectedValue,
                      selectedIndex: selectedIndex,
                      onTap: (String value, int index, int count) {
                        setState(() {
                          selectedValue = value;
                          selectedIndex = index;
                        });
                      },
                    ),

                    // Display the selected value and index
                    Text("Selected Index: $selectedIndex"),
                    Text("Selected Value: $selectedValue"),
                  ],
                ),
              ),
            ),

            SizedBox(
              child: Container(
                color: Colors.yellowAccent,
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const SizedBox(height: 120),

                    // Use the radioList function with myList
                    radioList(
                      title: "Choose an Option",
                      list:dayList,
                      selectedValue:"",
                      selectedIndex:0,
                      onTap: (String value, int index, int count) {
                        setState(() {
                          selectedValue = value;
                          selectedIndex = index;
                        });
                      },
                    ),

                    // Display the selected value and index
                    Text("Selected Index: $selectedIndex"),
                    Text("Selected Value: $selectedValue"),
                  ],
                ),
              ),
            ),


            // start here

            SizedBox(
              child: Container(
                color: Colors.grey,
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const SizedBox(height: 120),

                    // Use the radioList function with myList
                    radioList(
                      title: "Choose an Option",
                      list:instructionsTypes ,
                      selectedValue: instructionsCont.text,
                      selectedIndex: 0,
                      onTap: (String value, int index, int count) {
                        setState(() {
                          // selectedValue = value;
                          instructionsCont.text = value;
                          // selectedIndex = index;
                         print("instructionsCont => $index");
                        });
                      },

                    ),

                    // Display the selected value and index
                   Text(instructionsCont.text),

                  ],
                ),
              ),
            ),
            // Text(instructionsCont.text),
            SizedBox(
              child: Container(
                color: Colors.white24,
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const SizedBox(height: 120),

                    // Use the radioList function with myList
                    radioList(
                      title: "Choose an Option",
                      list:dayList ,
                      selectedValue: daysCont.text,
                      selectedIndex: 0,
                      onTap: (String value, int index, int count) {
                        setState(() {
                          // selectedValue = value;
                          print("cccc  $count");
                          daysCont.text = value;
                          // selectedIndex = index;
                          print("daysCont => $index");
                        });
                      },

                    ),

                    // Display the selected value and index
                    Text(daysCont.text),
                  ],
                ),
              ),
            ),

            SizedBox(
              child: Container(
                color: Colors.cyanAccent,
                child: Column(
                  children: [
                    Text("instructionsCont.text"),
                    Text(instructionsCont.text),
                    Text("daysCont.text"),
                    Text(daysCont.text),
                  ],
                ),

              ),
            ),


            // String selected, int index, int count
            Text("Typed"),
            edtRectField(
                hint: slot == 6?"Enter Instructions":"Select Instructions",
                filledColor: Colors.grey,
                focusBorderColor:
                Colors.lightBlueAccent,
                control: medicineTypeCont,
                isReadOnly: slot == 6?false:true,
                onTap: () {
                  if(slot!=6) {
                    int intervalCount = -1;
                    selectMedicineBottomSheet(
                        "Select medicine",
                       medicineTypes,
                        hint: "medincine",
                        keyboardType: TextInputType
                            .text,
                            (String selected,
                            int index, int count) {
                          Get.back();
                          intervalCount = count;
                          medicineTypeCont.text =
                              selected;
                        });
                  }
                },
                ),


            // Text("a"),

          ],
        ),
      ),
    );
  }





  Widget radioList({
    required String title,
    required List<String> list,
    required Function(String selectedValue, int selectedIndex, int count) onTap,
    required String selectedValue,
    required int selectedIndex,
  }) {
    return ListView.builder(
      itemCount: list.length,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        String item = list[index];
        return InkWell(
          onTap: () {
            onTap(item, index, list.length);
          },
          child: Row(
            children: [
              Radio<String>(
                value: item,
                groupValue: selectedValue,
                activeColor: Colors.green,
                onChanged: (String? value) {
                  if (value != null) {
                    onTap(value, index, list.length);
                  }
                },
              ),
              Text(item),
            ],
          ),
        );
      },
    );
  }

  selectMedicineBottomSheet(String title, List<String> list,
      Function(String selectedValue, int selectedIndex, int count) onTap,
      {String hint = "Times in a day", TextInputType keyboardType = TextInputType.number})
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
                        // Form(
                        //   key: bottomSheetFormKey,
                        //   child: Container(
                        //     margin: const EdgeInsets.only(left: 20, right: 30),
                        //     child: edtRectField(
                        //         hint: hint,
                        //         filledColor: Colors.grey,
                        //         focusBorderColor: Colors.blue,
                        //         control: frequencyCustomCont,
                        //         keyboardType: keyboardType,
                        //         ),
                        //   ),
                        // ),
                        const SizedBox(height: 10),
                        
                        ElevatedButton(onPressed: (){
                          if (list[selectedIndex] != "Custom") {
                            onTap(
                                selectedValue!, selectedIndex, selectedIndex + 1);
                          } else {
                            onTap(
                                frequencyCustomCont.text.toString(),
                                selectedIndex,
                                int.tryParse(frequencyCustomCont.text.toString()) ?? selectedIndex);
                          }
                        }, child: getTxtColor(msg: "OK", txtColor: Colors.cyan)),
                        // Text(""),
                        // btnProgress("Ok", bgColor: ColorConst.secondaryColor,
                        //     onTap: (startLoading, stopLoading, btnState) async {
                        //       if (btnState == ButtonState.idle) {
                        //
                        //         final form = bottomSheetFormKey?.currentState;
                        //         printLog(msg: "msg");
                        //
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
                      ]))));
    }));
  }



}

