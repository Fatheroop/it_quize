import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:it_quize/main.dart';

class Passwordboxhive {
  /* 1. students data contains name as {String key,String class}  String password, int rollNo 
     2. teacher data contains id of teacher as key ,password
     3. update data
     4. delete students
     5. addall students
     6. filter students */
  final passwordsbox = Hive.box("passwords");
  final teacherpassword = Hive.box("passwords").get(teachername);
  var keys = [];
  var filtered = [];
  String filtervalue = "";

  Passwordboxhive() {
    keys.addAll(passwordsbox.keys);
    keys.remove(teachername);
  }

  void updatedata(String oldkey, String name, String classno) {
    passwordsbox.put("${name.toLowerCase()}_$classno", [
      name.toLowerCase(),
      passwordsbox.get(oldkey)[1],
      classno,
    ]);
    passwordsbox.delete(oldkey);
    filter();
  }

  //Update data
  void add({
    required String name,
    String password = "123",
    required String classno,
  }) {
    var key = "${name.toLowerCase()}_$classno";
    passwordsbox.put(key, [name.toLowerCase(), password, classno]);
    filter();
  }

  //Update teacher
  void updateteacher(String password) {
    passwordsbox.put(teachername, password);
  }

  //delete data
  void delete({required String key, required String classno}) {
    passwordsbox.delete("${key.toLowerCase()}_$classno");
  }

  //Filter
  void filter() {
    keys.clear();
    keys.addAll(passwordsbox.keys);
    keys.remove(teachername);
    filtered.clear();
    debugPrint(keys.length.toString());
    for (int index = 0; index < keys.length; index++) {
      if (keys[index].toString().contains(filtervalue)) {
        filtered.add(keys[index].toString());
      }
    }
    keys.clear();
    keys.addAll(filtered);
  }
}
