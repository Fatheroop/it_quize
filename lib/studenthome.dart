import 'package:flutter/material.dart';
import 'package:flutter_glass_morphism/flutter_glass_morphism.dart';
import 'package:it_quize/login_page.dart';
import 'package:it_quize/studentboxhive.dart';
import 'package:it_quize/testdata.dart';
import 'package:it_quize/testhome.dart';
import 'package:it_quize/theme.dart';
import 'dart:async';

class Studenthome extends StatefulWidget {
  final String id;
  const Studenthome({super.key, required this.id});

  @override
  State<Studenthome> createState() => _StudenthomeState();
}

class _StudenthomeState extends State<Studenthome> {
  Timer? time;
  int _currentimageindex = 0;
  final studentbox = Studentboxhive();
  final testbox = Testdatamanage();
  final List<String> filterredkeys = [];

  final imageassests = [
    "assets/images/aot.jpg",
    "assets/images/rengoku.jpg",
    "assets/images/shinobu.jpg",
    "assets/images/zero_two1.jpg",
    "assets/images/zero_two2.jpg",
    "assets/images/zero_two3.jpg",
  ];

  @override
  void initState() {
    super.initState();
    for (String key in testbox.testbox.keys) {
      if (key.contains(studentbox.passwordsbox.get(widget.id)[2])) {
        filterredkeys.add(key);
      }
    }
    if (widget.id == "vicky_${studentClasses[0]}".toLowerCase()) {
      _starttimer();
    }
  }

  void _starttimer() {
    time = Timer.periodic(Duration(seconds: 20), (timer) {
      setState(() {
        if (_currentimageindex >= imageassests.length - 1) {
          _currentimageindex = 0;
        }
        _currentimageindex++;
      });
    });
  }

  @override
  void dispose() {
    time?.cancel();
    super.dispose();
  }

  Widget _currenttestoptions(Iterable<StudentTestData?> data) {
    if (data.isNotEmpty) {
      final datas = data.first;
      debugPrint(datas!.obtainedmarks.toString());
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Completed",
            style: MyTheme().textfieldtextstyle.copyWith(color: Colors.green),
          ),
          SizedBox(width: 10),
          Text(
            "Obtained Marks: ${datas.obtainedmarks}",
            style: MyTheme().textfieldtextstyle.copyWith(
              color: const Color.fromARGB(215, 245, 0, 139),
            ),
          ),
        ],
      );
    } else {
      return Text(
        "Pending",
        style: MyTheme().textfieldtextstyle.copyWith(color: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: MyTheme().appBar("Student Home"),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            opacity: 0.3,
            fit: BoxFit.cover,
            image: AssetImage(imageassests[_currentimageindex]),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 70),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Card.outlined(
                  color: const Color.fromARGB(143, 0, 0, 0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Name: ${studentbox.passwordsbox.get(widget.id)[0]}",
                          style: MyTheme().textfieldtextstyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          "Class: ${studentbox.passwordsbox.get(widget.id)[2]}",
                          style: MyTheme().textfieldtextstyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          "Score: ${studentbox.passwordsbox.get(widget.id)[3]}",
                          style: MyTheme().textfieldtextstyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext contex) => LoginPage(),
                      ),
                    );
                  },
                  child: Text(
                    "Log Out",
                    style: TextStyle(color: Colors.red, fontSize: 15),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: filterredkeys.length,
                itemBuilder: (context, index) {
                  final data = testbox.testbox.get(filterredkeys[index]);
                  var teststudentdata = testbox.testbox
                      .get(filterredkeys[index])!
                      .studentdata
                      .where(
                        (map) =>
                            map.studentname ==
                            studentbox.passwordsbox.get(widget.id)[0],
                      );
                  return GestureDetector(
                    onTap: () {
                      if (teststudentdata.isEmpty) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                StudentTestWidget(
                                  id: filterredkeys[index],
                                  studentid: widget.id,
                                ),
                          ),
                        );
                      }
                      debugPrint(teststudentdata.length.toString());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: BoxBorder.all(strokeAlign: 10),
                        color: const Color.fromARGB(163, 0, 0, 0),
                      ),
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data!.testname,
                            style: MyTheme().textfieldtextstyle,
                          ),
                          _currenttestoptions(teststudentdata),
                        ],
                      ),
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

class StudentTestWidget extends StatefulWidget {
  final String id;
  final String studentid;
  const StudentTestWidget({
    super.key,
    required this.id,
    required this.studentid,
  });

  @override
  State<StudentTestWidget> createState() => _StudentTestWidgetState();
}

class _StudentTestWidgetState extends State<StudentTestWidget> {
  final manage = Testdatamanage().testbox;
  int _currentquestionindex = 0;
  List<QuestionsData> originaldata = [];
  bool isQuzie = false;
  int totalmarks = 0;
  int obtainedmarks = 0;
  String greeting = "";
  int exp = 0;
  int time = 0;
  Timer? _timer;

  @override
  void initState() {
    time = manage.get(widget.id)!.testtime * 60;
    isQuzie = testtype[0] == manage.get(widget.id)!.testtype;
    debugPrint(isQuzie.toString());
    for (QuestionsData entity in manage.get(widget.id)!.questions) {
      totalmarks = totalmarks + entity.correctanswerindex.length;
      originaldata.add(
        QuestionsData(
          question: entity.question,
          answers: entity.answers,
          correctanswerindex: [],
          questiontype: entity.questiontype,
        ),
      );
    }
    _countdown();
    super.initState();
  }

  void _calculatetotal() {
    obtainedmarks = 0;
    final originaldatabase = manage.get(widget.id)!.questions;
    for (int i = 0; i < originaldatabase.length; i++) {
      for (int indexs in originaldata[i].correctanswerindex) {
        if (originaldatabase[i].correctanswerindex.contains(indexs)) {
          obtainedmarks++;
        }
      }
    }
  }

  void _appreciatation(bool greet) {
    greet ? exp++ : exp--;
    if (!greet && exp >= 1) {
      exp = 0;
    }
    switch (exp) {
      case -4:
        greeting = "Are you ok";
        break;
      case -3:
        greeting = "That's really bad";
        break;
      case -2:
        greeting = "That's bad";
        break;
      case -1:
        greeting = "Thats ok";
        break;
      case 0:
        greeting = "Not bad";
        break;
      case 1:
        greeting = "Good";
        break;
      case 2:
        greeting = "Good";
        break;
      case 3:
        greeting = "Greet";
        break;
      case 4:
        greeting = "Excellent";
        break;
      default:
        {
          if (exp > 4) {
            greeting = "Excellent +${exp / 4 + exp % 4}";
          } else {
            greeting = "No Hope";
          }
        }
    }
  }

  void _countdown() async {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        if (time > 0) {
          time--;
        } else {
          submittest();
          _timer!.cancel();
        }
      });
    });
  }

  void submittest() {
    setState(() {
      for (int option
          in originaldata[_currentquestionindex].correctanswerindex) {
        if (manage
            .get(widget.id)!
            .questions[_currentquestionindex]
            .correctanswerindex
            .contains(option)) {
          _appreciatation(true);
          obtainedmarks++;
        } else {
          _appreciatation(false);
        }
      }
      if (_currentquestionindex < originaldata.length - 1) {
        _currentquestionindex++;
      } else {
        _timer!.cancel();
        _calculatetotal();
        final studentbox = Studentboxhive().passwordsbox;
        final studentdata = studentbox.get(widget.studentid);
        studentdata[3] = studentdata[3] + obtainedmarks;
        studentbox.put(widget.studentid, [
          studentdata[0],
          studentdata[1],
          studentdata[2],
          studentdata[3],
        ]);

        final timetaken = manage.get(widget.id)!.testtime - (time / 60).toInt();
        final tsdata = manage.get(widget.id);
        tsdata!.studentdata.add(
          StudentTestData(
            studentname: studentbox.get(widget.studentid)[0],
            studentclass: studentbox.get(widget.studentid)[2],
            timetaken: timetaken,
            obtainedmarks: obtainedmarks,
            questiondata: originaldata,
          ),
        );
        tsdata.save();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                Studenthome(id: widget.studentid),
          ),
        );
      }
    });
  }

  Widget typemcqorradio(String type) {
    return SizedBox(
      width: 600,
      child: Column(
        children: [
          Text(
            originaldata[_currentquestionindex].question,
            style: MyTheme().textfieldtextstyle.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),

          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: originaldata[_currentquestionindex].answers.length,
            itemBuilder: (context, index) {
              final selectedquestion = originaldata[_currentquestionindex];
              return Container(
                color: Colors.transparent,
                margin: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Theme(
                        data: Theme.of(
                          context,
                        ).copyWith(canvasColor: Colors.transparent),
                        child: ChoiceChip(
                          selectedColor: Colors.black12,
                          checkmarkColor: Colors.pink,
                          backgroundColor: Colors.transparent,
                          label: Text(
                            "Option $index: ${selectedquestion.answers[index]}",
                            style: MyTheme().textfieldtextstyle,
                          ),
                          selected: selectedquestion.correctanswerindex
                              .contains(index),
                          onSelected: (value) {
                            setState(() {
                              if (value) {
                                if (Questiontype.mcq.name == type) {
                                  selectedquestion.correctanswerindex.clear();
                                }
                                selectedquestion.correctanswerindex.add(index);
                                if (type == Questiontype.mcq.name) {
                                  if (_currentquestionindex <
                                      originaldata.length - 1) {
                                    if (manage
                                            .get(widget.id)!
                                            .questions[_currentquestionindex]
                                            .correctanswerindex
                                            .contains(index) &&
                                        isQuzie) {
                                      _appreciatation(true);
                                      obtainedmarks++;
                                    } else if (isQuzie) {
                                      _appreciatation(false);
                                    }
                                    _currentquestionindex++;
                                  } else {
                                    submittest();
                                  }
                                }
                              } else {
                                selectedquestion.correctanswerindex.remove(
                                  index,
                                );
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget booleanquestion() {
    int length = originaldata[_currentquestionindex].correctanswerindex.length;

    bool booleanquestionoption = true;
    return Row(
      children: [
        Text(
          "Question: ${originaldata[_currentquestionindex].question}",
          style: MyTheme().textfieldtextstyle,
        ),
        SizedBox(width: 20),
        ChoiceChip(
          color: WidgetStatePropertyAll(Colors.black),
          label: Text("True", style: MyTheme().textfieldtextstyle),
          selected: booleanquestionoption && length > 0,
          checkmarkColor: Colors.green,
          onSelected: (value) {
            setState(() {
              booleanquestionoption = true;
              debugPrint("1");
              debugPrint("$value");
              if (value) {
                debugPrint(
                  "${originaldata.length}: currentquestionindex: $_currentquestionindex",
                );
                originaldata[_currentquestionindex].correctanswerindex.clear();
                originaldata[_currentquestionindex].correctanswerindex.add(0);
                debugPrint("This is true");
              }
              if (isQuzie &&
                  manage
                          .get(widget.id)!
                          .questions[_currentquestionindex]
                          .correctanswerindex[0] ==
                      0) {
                _appreciatation(true);
                obtainedmarks++;
                debugPrint("3");
              } else if (isQuzie &&
                  manage
                          .get(widget.id)!
                          .questions[_currentquestionindex]
                          .correctanswerindex[0] !=
                      0) {
                debugPrint("4");
                _appreciatation(false);
              }
              if (_currentquestionindex < originaldata.length - 1) {
                _currentquestionindex++;
              } else {
                submittest();
              }
              debugPrint("5");
            });
          },
        ),
        SizedBox(width: 10),
        ChoiceChip(
          color: WidgetStatePropertyAll(Colors.black),
          label: Text("False", style: MyTheme().textfieldtextstyle),
          selected: !booleanquestionoption && length > 0,
          checkmarkColor: Colors.green,
          onSelected: (value) {
            if (value) {
              setState(() {
                booleanquestionoption = false;
                originaldata[_currentquestionindex].correctanswerindex.clear();
                originaldata[_currentquestionindex].correctanswerindex.add(1);
                debugPrint("This is false");
                if (isQuzie &&
                    manage
                            .get(widget.id)!
                            .questions[_currentquestionindex]
                            .correctanswerindex[0] ==
                        1) {
                  _appreciatation(true);
                  obtainedmarks++;
                } else if (isQuzie &&
                    manage
                            .get(widget.id)!
                            .questions[_currentquestionindex]
                            .correctanswerindex[0] !=
                        1) {
                  _appreciatation(false);
                }
                if (_currentquestionindex < originaldata.length - 1) {
                  _currentquestionindex++;
                } else {
                  submittest();
                }
              });
            }
          },
        ),
      ],
    );
  }

  Widget questionrenderselecter() {
    if (originaldata[_currentquestionindex].questiontype ==
        Questiontype.mcq.name) {
      return typemcqorradio(Questiontype.mcq.name);
    } else if (originaldata[_currentquestionindex].questiontype ==
        Questiontype.radio.name) {
      return typemcqorradio(Questiontype.radio.name);
    } else {
      return booleanquestion();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            opacity: 0.3,
            fit: BoxFit.cover,
            image: AssetImage("assets/images/studenttestwidget.jpg"),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              greeting,
              style: MyTheme().textfieldtextstyle.copyWith(fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Time_Left: ${(time / 60).toInt()}:${time % 60}",
                  style: TextStyle(
                    color: time > 10 ? Colors.white60 : Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Pacifico",
                  ),
                ),
                isQuzie
                    ? Text(
                        "Marks: $obtainedmarks",
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Pacifico",
                        ),
                      )
                    : SizedBox(),
              ],
            ),
            SizedBox(height: 50),
            Center(
              child: GlassMorphismContainer(
                padding: EdgeInsets.all(10),
                blurIntensity: 0.01,
                opacity: 0.01,
                glassThickness: 0.01,
                child: SizedBox(
                  height: 300,
                  width: 900,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          isQuzie
                              ? SizedBox()
                              : IconButton(
                                  icon: Icon(Icons.navigate_before_outlined),
                                  onPressed: () {
                                    setState(() {
                                      if (_currentquestionindex > 0) {
                                        _currentquestionindex--;
                                      }
                                    });
                                  },
                                ),
                          SizedBox(width: 20),
                          Expanded(child: questionrenderselecter()),
                          SizedBox(width: 20),
                          IconButton(
                            icon: Icon(Icons.navigate_next_outlined),
                            onPressed: () {
                              setState(() {
                                if (_currentquestionindex <
                                    originaldata.length - 1) {
                                  _currentquestionindex++;
                                } else {}
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      originaldata[_currentquestionindex].questiontype ==
                                  Questiontype.radio.name ||
                              _currentquestionindex == originaldata.length - 1
                          ? OutlinedButton(
                              onPressed: () {
                                submittest();
                              },
                              child: Text(
                                "Submit",
                                style: MyTheme().textfieldtextstyle,
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
