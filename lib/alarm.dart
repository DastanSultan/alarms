import 'package:alarm/device.dart';
import 'package:flutter/material.dart';

class MyAlarm extends StatefulWidget {
  const MyAlarm({super.key});

  @override
  State<MyAlarm> createState() => _MyAlarmState();
}

class _MyAlarmState extends State<MyAlarm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30),
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Ваш будильник",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Text(
                " ${AlarmClock.uhr}",
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                ":",
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
              Text(
                " ${AlarmClock.min}",
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
