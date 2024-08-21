import 'package:basics/view/TimeView.dart';
import 'package:basics/view/date_one.dart';
import 'package:basics/view/dummy.dart';
import 'package:basics/view/ram.dart';
import 'package:basics/widget_helper/widget_helper.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  Dummy? dummy = Dummy();
  DateOne? dateOne;
  Ram? ram;
  Timeview? timeview;
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
                        iconPosition(Icons.home, 0),
                        iconPosition(Icons.date_range, 1),
                        iconPosition(Icons.schedule, 2),
                        iconPosition(Icons.schedule_send, 3)
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
    const Dummy(),
    const DateOne(),
    const Ram(),
    const Timeview()
  ];
}


