// ignore: file_names

import 'package:flutter/material.dart';
import 'package:it_quize/leader_board.dart';
import 'package:it_quize/login_page.dart';
import 'package:it_quize/studentboxhive.dart';
import 'package:it_quize/studentmanage.dart';
import 'package:it_quize/testdata.dart';
import 'package:it_quize/testhome.dart';
import 'package:it_quize/testresultshow.dart';
import 'package:it_quize/theme.dart';

class TeacherScreen extends StatefulWidget {
  const TeacherScreen({super.key});

  @override
  State<TeacherScreen> createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  var passworddailogboxshow = false;

  final testnamecontroller = TextEditingController();
  String filtervalue = "";
  Testdatamanage datacontroller = Testdatamanage();

  final List<IconData> optionsicons = [
    Icons.person_2_outlined,
    Icons.pages_outlined,
    Icons.key_off_rounded,
  ];
  final List<String> optiionstext = [
    "Student Manage",
    "Test Manage",
    "Change Password",
  ];

  @override
  Widget build(BuildContext context) {
    List<String> filterdkeys = [];
    for (String keys in datacontroller.testbox.keys) {
      if (keys.contains(filtervalue)) {
        filterdkeys.add(keys);
      }
    }
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: MyTheme().appBar("Test Management"),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/images/testmanage_background.jpg"),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 70),
            if (passworddailogboxshow)
              SizedBox(
                height: 200,
                width: 500,
                child: Changepassword(
                  callbackclose: () {
                    setState(() {
                      passworddailogboxshow = !passworddailogboxshow;
                      debugPrint("This is callback");
                    });
                  },
                ),
              )
            else
              SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => Studentmanage(),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Student Manage",
                      style: MyTheme().textfieldtextstyle,
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      passworddailogboxshow = !passworddailogboxshow;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Change Password",
                      style: MyTheme().textfieldtextstyle,
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            NewTestScreen(editmode: 'n'),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "New Test",
                      style: MyTheme().textfieldtextstyle,
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => LeaderBoard(),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "LeaderBoard",
                      style: MyTheme().textfieldtextstyle,
                    ),
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: TextField(
                    style: MyTheme().textfieldtextstyle,
                    onChanged: (value) {
                      setState(() {
                        filtervalue = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: MyTheme().border,
                      label: Text(
                        "Enter text Name to filter",
                        style: MyTheme().textfieldtextstyle,
                      ),
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage(),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Log Out",
                      style: MyTheme().textfieldtextstyle.copyWith(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: filterdkeys.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            filterdkeys[index],
                            style: MyTheme().textfieldtextstyle,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  fullscreenDialog: true,
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    backgroundColor: Colors.black,
                                    title: Text(
                                      "Warning!",
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                          213,
                                          255,
                                          48,
                                          48,
                                        ),
                                        fontSize: 15,
                                      ),
                                    ),
                                    content: Text(
                                      "Are you sure to delete this Test?\nPress yes to delete else click out of box.",
                                      style: TextStyle(
                                        color: Colors.white38,
                                        fontSize: 10,
                                      ),
                                    ),
                                    actions: [
                                      OutlinedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                                Colors.black12,
                                              ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            datacontroller.testbox.delete(
                                              filterdkeys[index],
                                            );
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Text(
                                          "Yes",
                                          style: MyTheme().textfieldtextstyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              color: const Color.fromARGB(255, 184, 184, 184),
                              icon: Icon(Icons.delete),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        NewTestScreen(
                                          editmode: 'e',
                                          testkey: filterdkeys[index],
                                        ),
                                  ),
                                );
                              },
                              color: const Color.fromARGB(255, 172, 172, 172),
                              icon: Icon(Icons.edit_document),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ResultHome(testid: filterdkeys[index]),
                                  ),
                                );
                              },
                              color: const Color.fromARGB(255, 172, 172, 172),
                              icon: Icon(Icons.person_2_sharp),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Changepassword extends StatefulWidget {
  final VoidCallback callbackclose;
  const Changepassword({super.key, required this.callbackclose});

  @override
  State<Changepassword> createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {
  final box = Studentboxhive();
  final oldpasswordcontroller = TextEditingController();
  final newpasswordcontroller = TextEditingController();
  var unlocknewpassword = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          autofocus: true,
          style: MyTheme().textfieldtextstyle,
          controller: oldpasswordcontroller,
          onChanged: (value) {
            setState(() {
              if (oldpasswordcontroller.text == box.teacherpassword) {
                unlocknewpassword = true;
                debugPrint("This is if check");
              } else {
                unlocknewpassword = false;
                debugPrint("This is else check");
              }
            });
          },
          decoration: InputDecoration(
            border: MyTheme().border,
            label: Text(
              "Enter Old Password",
              style: MyTheme().textfieldtextstyle,
            ),
          ),
          maxLines: 1,
        ),
        SizedBox(height: 20),
        unlocknewpassword
            ? TextField(
                controller: newpasswordcontroller,
                style: MyTheme().textfieldtextstyle,
                decoration: InputDecoration(
                  border: MyTheme().border,
                  label: Text(
                    "Enter new password",
                    style: MyTheme().textfieldtextstyle,
                  ),
                ),
                maxLines: 1,
              )
            : SizedBox(),
        SizedBox(height: 30),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.black87),
          ),
          onPressed: () {
            if (unlocknewpassword && newpasswordcontroller.text.isNotEmpty) {
              setState(() {
                box.updateteacher(newpasswordcontroller.text);
                widget.callbackclose();
              });
              debugPrint("Pressing button");
            }
          },
          child: Text("Change Password", style: TextStyle(fontFamily: "Lato")),
        ),
      ],
    );
  }
}
