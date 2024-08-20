import 'package:basics/services/notification_service.dart';
import 'package:flutter/material.dart';



class Ram extends StatelessWidget {
  const Ram({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Row(
            children: [],
          ),
          ElevatedButton.icon(
            onPressed: () {
              Future.delayed(Duration(seconds: 5)).then((s) {
                NotificationService().showNotification(
                  id: 1,
                  body: "Welcome",
                  payload: "now",
                  title: "New Notification",
                );
              });
            },
            label: Text("Show Notification"),
            icon: Icon(Icons.notifications),
          )
        ],
      ),
    );
  }
}
