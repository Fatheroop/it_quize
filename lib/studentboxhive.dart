import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:it_quize/main.dart';

class Studentboxhive {
  /* 1. students data contains name as {String key,String class}  String password, int rollNo 
     2. teacher data contains id of teacher as key ,password
     3. update data
     4. delete students
     5. addall students
     6. filter students */
  final passwordsbox = Hive.box("students");
  final teacherpassword = Hive.box("students").get(teachername);
  var keys = [];
  var filtered = [];
  String filtervalue = "";

  Studentboxhive() {
    keys.addAll(passwordsbox.keys);
    keys.remove(teachername);
  }

  void updatedata(String oldkey, String name, String classno) {
    debugPrint(oldkey);
    if (oldkey == "${name.toLowerCase()}_$classno") {
      return;
    } else {
      passwordsbox.put("${name.toLowerCase()}_$classno", [
        name.toLowerCase(),
        passwordsbox.get(oldkey)[1],
        classno,
        passwordsbox.get(oldkey)[3],
      ]);
      debugPrint("new.${name.toLowerCase()}_$classno");
      passwordsbox.delete(oldkey);

      filter();
    }
  }

  //Update data
  void add({
    required String name,
    String password = "123",
    required String classno,
    int marks = 0,
  }) {
    var key = "${name.toLowerCase()}_$classno";
    passwordsbox.put(key, [name.toLowerCase(), password, classno, marks]);
    filter();
  }

  //Update teacher
  void updateteacher(String password) {
    passwordsbox.put(teachername, password);
  }

  //Filter
  void filter() {
    keys.clear();
    keys.addAll(passwordsbox.keys);
    keys.remove(teachername);
    filtered.clear();
    for (int index = 0; index < keys.length; index++) {
      if (keys[index].toString().contains(filtervalue)) {
        filtered.add(keys[index].toString());
      }
    }
    keys.clear();
    keys.addAll(filtered);
  }
}
