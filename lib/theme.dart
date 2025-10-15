import 'package:flutter/material.dart';

class MyTheme {
  final backgroundcolor = Colors.black12;
  final Color textfieldtextcolor = const Color.fromARGB(255, 223, 223, 223);
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(color: Color.fromARGB(166, 221, 221, 221)),
  );
  final textfieldtextstyle = TextStyle(
    color: const Color.fromARGB(255, 162, 162, 162),
    fontSize: 10,
  );
}
