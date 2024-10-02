import 'package:basics/view/TimeView.dart';
import 'package:basics/view/date_one.dart';
import 'package:basics/view/dummy.dart';
import 'package:basics/view/first_dose.dart';
import 'package:basics/view/local_storage.dart';
import 'package:basics/view/local_storage_two.dart';
import 'package:basics/view/normal.dart';
import 'package:basics/view/ram.dart';
import 'package:basics/view/second_dose.dart';
import 'package:basics/view/time_view_common.dart';
import 'package:basics/view/time_view_common_second.dart';
import 'package:basics/widget_helper/widget_helper.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  // Dummy? dummy = Dummy();
  LocalStorage? localStorage = LocalStorage();
  LocalStorageTwo? localStorageTwo;
  FirstDose? firstDose;
  SecondDose? secondDose;
  Normal? normal;
  TimeViewCommon? timeViewCommon;
  TimeViewCommonSecond? timeViewCommonSecond;
  Timeview? timeview;
  DateOne? dateOne;
  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: false,
      onPopInvoked: (bool isPop) async {
        print("msg isPop $isPop");
        if(!isPop) {
          onWillPop();
        }
      },
      child: Scaffold(
          backgroundColor: _selectedIndex == 0
              ? Colors.blue
              : Colors.grey,

          bottomNavigationBar: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(24), topLeft: Radius.circular(24)),
              child: BottomAppBar(
                  color: Colors.white,
                  height: 70,
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        iconPosition(Icons.one_k, 0),
                        iconPosition(Icons.two_k, 1),
                        iconPosition(Icons.three_k, 2),
                        iconPosition(Icons.four_k, 3),
                        iconPosition(Icons.five_k, 4),
                      ]))),
          body: _widgetOptions.elementAt(_selectedIndex)),


    );

  }
  iconPosition(IconData iconData, int index) {
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Icon(iconData, color: _selectedIndex == index
            ? Colors.cyan
            : Colors.grey),
      ),
    );
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  final _widgetOptions = [
    // const Dummy(),
    const LocalStorage(),
    const LocalStorageTwo(),
    const FirstDose(),
    const SecondDose(),
    const TimeViewCommon(),
    const TimeViewCommonSecond(),
    const Normal(),
    const DateOne(),
    const Timeview(),

  ];
}


