import 'dart:convert';
import 'package:basics/model/TimeModel.dart';
import 'package:basics/widget_helper/textbutton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget_helper/widget_helper.dart';

class LocalStorage extends StatefulWidget {
  const LocalStorage({super.key});

  @override
  State<LocalStorage> createState() => _LocalStorageState();
}

class _LocalStorageState extends State<LocalStorage> {
  final TextEditingController _idController = TextEditingController();
  List<TextEditingController> _valueControllers = [];
  List<String> _currentList = [];
  TimeOfDay timeOfDay = TimeOfDay.now();
  List<TimeModel> timerlist = [];

  @override
  void dispose() {
    _idController.dispose();
    for (var controller in _valueControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _createOrRetrieveList() async {
    final prefs = await SharedPreferences.getInstance();
    int id = int.parse(_idController.text);

    // Retrieve the list by ID (key)
    String? listJson = prefs.getString('list_$id');
    if (listJson != null) {
      _currentList = List<String>.from(json.decode(listJson));
    } else {
      // Create a new list with the length of ID
      _currentList = List<String>.filled(id, "", growable: true);
      await prefs.setString('list_$id', json.encode(_currentList));
    }

    // Update timerList to match the currentList values
    timerlist = List.generate(id, (index) {
      String timeValue = _currentList[index];
      String? time, format;

      if (timeValue.isNotEmpty) {
        List<String> splitValue = timeValue.split(' ');
        if (splitValue.length == 2) {
          time = splitValue[0];
          format = splitValue[1];
        }
      }

      return TimeModel(time: time ?? "", timeFormat: format ?? "");
    });

    setState(() {});
  }


  Future<void> _saveSingleValue(int index, String value) async {
    final prefs = await SharedPreferences.getInstance();
    int id = int.parse(_idController.text);

    // Update the current list with the new value
    _currentList[index] = value;

    // Save the updated list back to SharedPreferences
    await prefs.setString('list_$id', json.encode(_currentList));

    setState(() {});
  }

  Future<void> _saveValuesToList() async {
    final prefs = await SharedPreferences.getInstance();
    int id = int.parse(_idController.text);

    for (int i = 0; i < _valueControllers.length; i++) {
      _currentList[i] = _valueControllers[i].text;
    }

    // Save the updated list back to SharedPreferences
    await prefs.setString('list_$id', json.encode(_currentList));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dynamic Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 60),

              TextField(
                controller: _idController,
                // decoration: InputDecoration(labelText: 'Enter ID (1 to 20)'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _createOrRetrieveList,
                child: Text('Create/Retrieve List by ID'),
              ),
              SizedBox(height: 20),

              if (_currentList.isNotEmpty) ...[
                Text('Current List: $_currentList'),
                SizedBox(height: 20),
                // Iterate over timerList instead of _valueControllers
                ...timerlist.asMap().entries.map((entry) {
                  int index = entry.key;
                  TimeModel item = entry.value;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: getTimerList(item, () {
                      setState(() {});
                    }, index),
                  );
                }).toList(),
                SizedBox(height: 20)
                // ElevatedButton(
                //   onPressed: _saveValuesToList,
                //   child: Text('Save Values'),
                // ),
              ],

              Align(
                alignment: Alignment.bottomLeft,
                  child: btnCorner("nothing", ()
                  {
                    // List<int> items = [1, 2, 3];
                    //
                    // List<bool> newItems = items.asMap().entries.map((MapEntry<int, int> entry) {
                    //
                    //   return entry.key == 2;
                    // }).toList();
                    //
                    // print("newItems");
                    // print("------------------------------------");
                    // print(newItems);


                    // List<bool> items = [false, false, false];
                    //
                    // items.asMap().entries.forEach((MapEntry<int, bool> entry) {
                    //   items[entry.key] = entry.key == 1;
                    // });
                    //
                    // print(items);

                    // List<bool> items = [false, false, false];
                    //
                    // List<bool> newItems = items.indexed.map(((int, bool) item) {
                    //   final (index, value) = item;
                    //
                    //   return index == 1;
                    // }).toList();
                    //
                    // print("------------------------------------");
                    // print(newItems);
                    List<bool> items = [false, false, false];

                    for (final (int, bool) item in items.indexed) {
                      final index = item.$1;

                      items[index] = index == 1;
                    }

                    print(items);

                  })
              )
            ],
          ),
        ),
      ),


      floatingActionButton:showUndo==false?null:FloatingActionButton.large(
        onPressed: (){setState(() {
          r();
        });},
        elevation: 0.1,
        backgroundColor: Colors.transparent,
        child: getTxtBlackColor(msg: "Undo"),

      )
    );

  }

bool showUndo = false;


  r(){
    showUndo=!showUndo;
    setState(() {

    });
  }

  Widget getTimerList(TimeModel item, Function onTap, int index) {
    TextEditingController medicineTimeCont = TextEditingController();
    TextEditingController periodCont = TextEditingController();

    if (item.time?.isNotEmpty == true && item.time != "null") {
      medicineTimeCont.text = item.time!;
      periodCont.text = item.timeFormat!;
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
                    setState(() {
                      item.time = time;
                      item.timeFormat = format;
                      _currentList[index] = "$time $format";
                    });
                    _saveSingleValue(index, _currentList[index]);
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
                      _currentList[index] = "$time $format";
                    });
                    _saveSingleValue(index, _currentList[index]);
                    onTap();
                  });
                },
              ),
            ),
            Flexible(
              flex: 1,
              child: IconButton(
                onPressed: () {

                  r();





                  print("asdfasdf");



                  Future.delayed(Duration(seconds: 5), () {
                    if(showUndo==false){
                      print("ssssssss");
                      return;
                    }


                    print("zzzzzzzz");
                    r();

                    setState(() {
                      item.time = "";
                      item.timeFormat = "";
                      _currentList[index] = "";
                    });
                    _saveSingleValue(index, _currentList[index]);
                    onTap();
                  });
                },
                icon: const Icon(Icons.clear),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future displayTimePicker(Function(String time, String format, DateTime selectedDateTime) selectedTimeClick) async {
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
}
