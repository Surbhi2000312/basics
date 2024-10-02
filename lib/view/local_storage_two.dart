import 'package:basics/SP/sp_helper.dart';
import 'package:basics/SP/sp_manager.dart';  // Import SpManager
import 'dart:convert';
import 'package:basics/model/TimeModel.dart';
import 'package:basics/widget_helper/textbutton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widget_helper/widget_helper.dart';

class LocalStorageTwo extends StatefulWidget {
  const LocalStorageTwo({super.key});

  @override
  State<LocalStorageTwo> createState() => _LocalStorageTwoState();
}

class _LocalStorageTwoState extends State<LocalStorageTwo> {
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
    int id = int.parse(_idController.text);

    // Use SpManager to create or retrieve the list
    _currentList = await SpManager.createOrRetrieveList(id);

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
    int id = int.parse(_idController.text);

    // Update the current list with the new value
    _currentList[index] = value;

    // Use SpManager to save the updated list
    await SpManager.setList(id, _currentList);

    setState(() {});
  }

  Future<void> _saveValuesToList() async {
    int id = int.parse(_idController.text);

    for (int i = 0; i < _valueControllers.length; i++) {
      _currentList[i] = _valueControllers[i].text;
    }

    // Use SpManager to save the updated list
    await SpManager.setList(id, _currentList);
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
                SizedBox(height: 20),
              ],

              // Align(
              //     alignment: Alignment.bottomLeft,
              //     child: btnCorner("nothing", () {
              //       // Additional logic here
              //     })
              // )
            ],
          )
        ),
      ),
      floatingActionButton: showUndo == false ? null : FloatingActionButton.large(
        onPressed: () { setState(() { r(); }); },
        elevation: 0.1,
        backgroundColor: Colors.transparent,
        child: getTxtBlackColor(msg: "Undo"),
      ),
    );
  }

  bool showUndo = false;

  r() {
    showUndo = !showUndo;
    setState(() {});
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

                  Future.delayed(Duration(seconds: 5), () {
                    if (showUndo == false) {
                      return;
                    }

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
