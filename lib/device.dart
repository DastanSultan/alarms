import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:alarm/alarm.dart';
import 'package:alarm/style.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'icons.dart'; // Предполагается, что у вас есть файл icons.dart

class Device extends StatefulWidget {
  const Device({Key? key}) : super(key: key);

  @override
  State<Device> createState() => _DeviceState();
}

final player = AudioPlayer();

class MinUhr {
  static int uhr = 14;
  static int min = 25;
}

class AlarmClock {
  static int uhr = 22;
  static int min = 52;
  static bool alarms = false;
}

late DateTime date;

stop() {
  AlarmClock.alarms;
}

class _DeviceState extends State<Device> {
  @override
  void initState() {
    super.initState();
    date = DateTime.now();
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        date = DateTime.now();
        if (AlarmClock.uhr == date.hour && AlarmClock.min == date.minute) {
          print("Wecker");
          stop();
        } else {
          print("Noch nicht");
          AlarmClock.alarms = false;
        }
        load();
      });
    });
  }

  Future<void> save() async {
    SharedPreferences saved = await SharedPreferences.getInstance();
    saved.setInt("min", MinUhr.min);
    saved.setInt("uhr", MinUhr.uhr);
  }

  Future<void> load() async {
    SharedPreferences saveds = await SharedPreferences.getInstance();
    setState(() {
      AlarmClock.min = saveds.getInt("min") ?? 0;
      AlarmClock.uhr = saveds.getInt("uhr") ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(),
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/wood-591631.jpg"),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Column(
                      children: [
                        icons(Icons.expand_less, () {
                          setState(() {
                            MinUhr.uhr++;
                            if (MinUhr.uhr == 24) {
                              MinUhr.uhr = 0;
                            }
                          });
                        }),
                        Text(
                          MinUhr.uhr < 10 ? "0${MinUhr.uhr}" : "${MinUhr.uhr}",
                          style: TextStyles,
                        ),
                        icons(Icons.expand_more, () {
                          setState(() {
                            MinUhr.uhr--;
                            if (MinUhr.uhr == -1) {
                              MinUhr.uhr = 23;
                            }
                          });
                        }),
                      ],
                    ),
                  ),
                  Text(
                    ":",
                    style: TextStyles,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Column(
                      children: [
                        icons(Icons.expand_less, () {
                          setState(() {
                            MinUhr.min++;
                            if (MinUhr.min == 60) {
                              MinUhr.min = 0;
                            }
                          });
                        }),
                        Text(
                          MinUhr.min < 10 ? "0${MinUhr.min}" : "${MinUhr.min}",
                          style: TextStyles,
                        ),
                        icons(Icons.expand_more, () {
                          setState(() {
                            MinUhr.min--;
                            if (MinUhr.min == -1) {
                              MinUhr.min = 59;
                            }
                          });
                        }),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    save();
                    load();
                    AlarmClock.alarms = true;
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Установить",
                    style: TextClick,
                  ),
                ),
              ),
              SizedBox(height: 40),
              MyAlarm(),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  AlarmClock.alarms == true
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              AlarmClock.alarms = false;
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 0, 0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Отключить",
                              style: OffAlarm,
                            ),
                          ),
                        )
                      : Text(''),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
