import 'package:flutter/material.dart';

Widget icons(IconData icon, Function() plus) {
  return InkWell(
    onTap: () {
      plus();
    },
    child: Container(
        child: Icon(
      icon,
      size: 40,
      color: Colors.white,
    )),
  );
}
