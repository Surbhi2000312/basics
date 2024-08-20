import 'package:basics/widget_helper/textbutton.dart';
import 'package:flutter/material.dart';

class Dummy extends StatefulWidget {
  const Dummy({super.key});

  @override
  State<Dummy> createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
  late int selectedRadio;

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
 int selectedIndex=  0;
  String? selectedValue = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SingleChildScrollView(
        child: Column(

          children: [
            SizedBox(height: 120,),
            SizedBox(
              // height: 500,
              child: ListView.builder(
                  // itemCount: 3,
                  itemCount: list.length ?? 0,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context ,int index){
                    int item = list[index];
                    return  InkWell(
                      onTap: (){
                        selectedIndex = index;

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
                              selectedIndex=index;
                              selectedValue=val.toString();
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
              child: getTxtBlackColor(msg: selectedIndex.toString()),
            ),
            SizedBox(
              child: getTxtBlackColor(msg: selectedValue.toString()),
            ),


            // ButtonBar(
            //   alignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     Radio(
            //       value: 1,
            //       groupValue: selectedRadio,
            //       activeColor: Colors.green,
            //       onChanged: (val) {
            //         print("Radio $val");
            //         setSelectedRadio(val!);
            //       },
            //     ),
            //     Radio(
            //       value: 2,
            //       groupValue: selectedRadio,
            //       activeColor: Colors.blue,
            //       onChanged: (val) {
            //         print("Radio $val");
            //         setSelectedRadio(val!);
            //       },
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
