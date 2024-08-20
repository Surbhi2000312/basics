import 'package:basics/model/TimeModel.dart';
import 'package:basics/services/notification_service.dart';
import 'package:basics/widget_helper/textbutton.dart';
import 'package:basics/widget_helper/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class Timeview extends StatefulWidget {
  const Timeview({super.key});

  @override
  State<Timeview> createState() => _TimeviewState();
}

class _TimeviewState extends State<Timeview> {
  List<TimeModel> timerList = [];
  final NotificationService _notificationService = NotificationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60,),
            Text("Reminder"),

            for (int i = 0; i < timerList.length; i++)
              getTimerList(timerList[i], () {
                setState(() {});
              }),
            TextButton(
              onPressed: () {
                setState(() {
                  // Assign a unique ID using a random number generator or use a counter
                  int uniqueId = Random().nextInt(1000000);
                  timerList.add(TimeModel(uniqueId: uniqueId));
                });
              },
              child: getTxtColor(
                  msg: "+ Add More Time",
                  txtColor: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }

  Widget getTimerList(TimeModel item, Function onTap) {
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
                    _testNotification(item.uniqueId!, difference.inSeconds);
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
                    _notificationService.cancelNotification(item.uniqueId!);
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

  void _testNotification(int? uniqueId, int sec) async {
    Future.delayed(Duration(seconds: sec)).then((s) {
      if (uniqueId == null) {
        print("Notification cancelled: Unique ID is null.");
        return;
      }

      int index = timerList.indexWhere((item) => item.uniqueId == uniqueId);

      if (index == -1) {
        print("Notification cancelled: Timer with uniqueId $uniqueId no longer exists.");
        return;
      }

      NotificationService().showNotification(
        id: uniqueId,
        body: "Timer at index $index",
        payload: "now",
        title: "test Notification \n ${timerList[index].time.toString()}",
      );

      // Remove the item from the list after notification is sent
      setState(() {
        timerList.removeAt(index);
      });
    });
  }

}
