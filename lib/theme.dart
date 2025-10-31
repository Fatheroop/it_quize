import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  AppBar appBar(String title) {
    return AppBar(
      actions: [
        OutlinedButton(
          onPressed: () {
            SystemNavigator.pop();
            exit(0);
          },
          child: Text(
            "Close Application",
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 10,
              fontFamily: "Pacifico",
            ),
          ),
        ),
      ],
      iconTheme: IconThemeData(color: Colors.white),
      toolbarHeight: 70,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: MyTheme().textfieldtextstyle.copyWith(
            fontSize: 30,
            fontFamily: "Pacifico",
          ),
        ),
      ),
    );
  }
}
