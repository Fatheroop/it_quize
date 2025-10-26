import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:it_quize/login_page.dart';
import 'package:it_quize/main.dart';
import 'package:it_quize/teacher.dart';
import 'package:it_quize/testdata.dart';
import 'package:it_quize/theme.dart';

enum Questiontype { mcq, radio, boolean }

class NewTestScreen extends StatefulWidget {
  final String editmode;
  final String testkey;
  const NewTestScreen({super.key, required this.editmode, this.testkey = ""});

  @override
  State<NewTestScreen> createState() => _NewTestScreenState();
}

class _NewTestScreenState extends State<NewTestScreen> {
  final manage = Testdatamanage();
  final testnameeditor = TextEditingController();
  final testimecontroller = TextEditingController();
  var selectedclass = studentClasses[0];
  var selectedquestionindex = 0;
  var errortextstate = false;
  var errortext = "";
  var selectedquestiontype = Questiontype.mcq.name;
  List<QuestionsData> questions = [];
  final List<TextEditingController> optionscontroller = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  final List<FocusNode> optionsfocusnode = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];
  final addbuttonbuttonfocusnode = FocusNode();
  final questiontextcontroller = TextEditingController();
  String testype = testtype[0];

  @override
  void initState() {
    super.initState();
    if (widget.editmode == 'e') {
      var data = manage.testbox.get(widget.testkey);
      testnameeditor.text = data!.testname.toString();
      selectedclass = data.classno;
      testimecontroller.text = data.testtime.toString();
      questions = data.questions;
    }
    debugPrint(testnameeditor.text);
  }

  Widget typemcqorradio(String type) {
    final questionfocusnode = FocusNode();
    questionfocusnode.requestFocus();
    if (questions[selectedquestionindex].answers.isEmpty) {
      questions[selectedquestionindex].answers.addAll(["", "", "", ""]);
    }
    debugPrint("$selectedquestionindex: questionlength:  ${questions.length}");
    questiontextcontroller.text = questions[selectedquestionindex].question;
    return SizedBox(
      width: 600,
      child: Column(
        children: [
          TextField(
            maxLines: 1,
            focusNode: questionfocusnode,
            controller: questiontextcontroller,
            decoration: InputDecoration(
              border: MyTheme().border,
              label: Text("Question", style: MyTheme().textfieldtextstyle),
            ),
            style: MyTheme().textfieldtextstyle,
            onChanged: (value) {
              questions[selectedquestionindex].question = value;
            },
            onSubmitted: (value) {
              optionsfocusnode[0].requestFocus();
            },
          ),

          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: optionscontroller.length,
            itemBuilder: (context, index) {
              final selectedquestion = questions[selectedquestionindex];
              optionscontroller[index].text = selectedquestion.answers[index];
              return Container(
                margin: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ChoiceChip(
                      checkmarkColor: Colors.pink,
                      color: WidgetStatePropertyAll(Colors.black),
                      label: Text(
                        "Correct",
                        style: MyTheme().textfieldtextstyle,
                      ),
                      selected: selectedquestion.correctanswerindex.contains(
                        index,
                      ),
                      onSelected: (value) {
                        setState(() {
                          if (value) {
                            if (Questiontype.mcq.name == type) {
                              selectedquestion.correctanswerindex.clear();
                            }
                            selectedquestion.correctanswerindex.add(index);
                          } else {
                            selectedquestion.correctanswerindex.remove(index);
                          }
                        });
                      },
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        focusNode: optionsfocusnode[index],
                        maxLines: 1,
                        controller: optionscontroller[index],
                        decoration: InputDecoration(
                          border: MyTheme().border,
                          label: Text(
                            "Option $index",
                            style: MyTheme().textfieldtextstyle,
                          ),
                        ),
                        style: MyTheme().textfieldtextstyle,
                        onChanged: (value) {
                          selectedquestion.answers[index] = value;
                        },
                        onSubmitted: (value) {
                          if (index < optionscontroller.length - 1) {
                            optionsfocusnode[index + 1].requestFocus();
                          } else {
                            addbuttonbuttonfocusnode.requestFocus();
                          }
                        },
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
    final questionfocusnode = FocusNode();
    questionfocusnode.requestFocus();
    questiontextcontroller.text = questions[selectedquestionindex].question;
    if (questions[selectedquestionindex].answers.isEmpty) {
      questions[selectedquestionindex].answers.add("true");
      questions[selectedquestionindex].answers.add("false");
    }
    if (questions[selectedquestionindex].correctanswerindex.isEmpty) {
      questions[selectedquestionindex].correctanswerindex.add(0);
    }
    var booleanquestionoption = true;
    if (questions[selectedquestionindex].correctanswerindex[0] == 0) {
      booleanquestionoption = true;
    } else {
      booleanquestionoption = false;
    }
    return Row(
      children: [
        Expanded(
          child: TextField(
            maxLines: 3,
            focusNode: questionfocusnode,
            controller: questiontextcontroller,
            decoration: InputDecoration(
              enabledBorder: MyTheme().border,
              focusedBorder: MyTheme().border,
              label: Text("Question", style: MyTheme().textfieldtextstyle),
            ),
            style: MyTheme().textfieldtextstyle,
            onChanged: (value) {
              questions[selectedquestionindex].question = value;
            },
            onSubmitted: (value) {
              optionsfocusnode[0].requestFocus();
            },
          ),
        ),
        SizedBox(width: 20),
        ChoiceChip(
          color: WidgetStatePropertyAll(Colors.black),
          label: Text("True", style: MyTheme().textfieldtextstyle),
          selected: booleanquestionoption,
          checkmarkColor: Colors.green,
          onSelected: (value) {
            if (value) {
              setState(() {
                questions[selectedquestionindex].correctanswerindex[0] = 0;
              });
            }
          },
        ),
        SizedBox(width: 10),
        ChoiceChip(
          color: WidgetStatePropertyAll(Colors.black),
          label: Text("False", style: MyTheme().textfieldtextstyle),
          selected: !booleanquestionoption,
          checkmarkColor: Colors.green,
          onSelected: (value) {
            if (value) {
              setState(() {
                questions[selectedquestionindex].correctanswerindex[0] = 1;
              });
            }
          },
        ),
      ],
    );
  }

  Widget questionrenderselecter() {
    if (questions[selectedquestionindex].questiontype ==
        Questiontype.mcq.name) {
      return typemcqorradio(Questiontype.mcq.name);
    } else if (questions[selectedquestionindex].questiontype ==
        Questiontype.radio.name) {
      return typemcqorradio(Questiontype.radio.name);
    } else {
      return booleanquestion();
    }
  }

  void checkdatasubmit() {
    var errorfound = false;
    setState(() {
      if (manage.checktestpreexist("${testnameeditor.text}_$selectedclass") &&
          widget.editmode == 'n') {
        errorfound = true;
        errortext = "Test already exist";
        errortextstate = true;
      }
      if (testnameeditor.text.isEmpty ||
          questions.isEmpty ||
          testimecontroller.text == "") {
        errortextstate = true;
        if (testnameeditor.text.isEmpty) {
          errortext = "Test Name cannot be empty";
          errorfound = true;
        } else if (questions.isEmpty) {
          errortext = "No Question Found";
          errorfound = true;
        } else if (testimecontroller.text == "") {
          errorfound = true;
          errortext = "Time cannot be empty";
          errortextstate = true;
        }
      }
      for (QuestionsData entity in questions) {
        if (entity.answers.contains("")) {
          errortextstate = true;
          errortext = "Options are missing";
          selectedquestionindex = questions.indexOf(entity);
          errorfound = true;
          break;
        } else if (entity.question == "") {
          errortext = "Question is missing";
          errortextstate = true;
          errorfound = true;
          break;
        }
      }
      if (errorfound == false) {
        final data = Testdatahive(
          testname: testnameeditor.text,
          testtime: int.parse(testimecontroller.text),
          classno: selectedclass,
          questions: questions,
          testtype: testype,
        );
        if (widget.editmode == 'n') {
          manage.addtest(data);
        } else if (widget.editmode == 'e') {
          if (widget.testkey == "${testnameeditor.text}_$selectedclass") {
            manage.testbox.put(widget.testkey, data);
          } else {
            manage.updatetest(
              widget.testkey,
              "${testnameeditor.text}_$selectedclass",
              data,
            );
          }
        }
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (BuildContext context) => TeacherScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: MyTheme().appBar("New Test"),
      body: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          image: DecorationImage(
            opacity: 0.2,
            fit: BoxFit.cover,
            image: AssetImage("assets/images/newtest_background.jpeg"),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 70),
            errortextstate
                ? Text(
                    errortext,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : SizedBox(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: testnameeditor,
                    decoration: InputDecoration(
                      border: MyTheme().border,
                      label: Text("Test Name"),
                    ),
                    style: MyTheme().textfieldtextstyle,
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: TextField(
                    keyboardType: TextInputType.numberWithOptions(),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    controller: testimecontroller,
                    decoration: InputDecoration(
                      border: MyTheme().border,
                      label: Text(
                        "Test Time In Minutes",
                        style: MyTheme().textfieldtextstyle,
                      ),
                    ),
                    style: MyTheme().textfieldtextstyle,
                  ),
                ),
                Text(testype, style: MyTheme().textfieldtextstyle),
                Switch(
                  value: testype == testtype[0],
                  onChanged: (condition) {
                    setState(() {
                      if (condition) {
                        testype = testtype[0];
                      } else {
                        testype = testtype[1];
                      }
                    });
                  },
                ),
                ClassChoiceChip(
                  selectedclass: selectedclass,
                  callbackfunction: (String selected) {
                    setState(() {
                      selectedclass = selected;
                    });
                  },
                ),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      checkdatasubmit();
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.black45),
                  ),
                  child: Text("Submit", style: MyTheme().textfieldtextstyle),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => TeacherScreen(),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.black45),
                  ),

                  child: Text("Cancel", style: MyTheme().textfieldtextstyle),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ChoiceChip(
                  color: WidgetStatePropertyAll(Colors.black),
                  checkmarkColor: Colors.blue,
                  label: Text(
                    Questiontype.mcq.name,
                    style: MyTheme().textfieldtextstyle,
                  ),
                  selected: selectedquestiontype == Questiontype.mcq.name,
                  onSelected: (value) {
                    setState(() {
                      selectedquestiontype = Questiontype.mcq.name;
                    });
                  },
                ),
                ChoiceChip(
                  color: WidgetStatePropertyAll(Colors.black),
                  label: Text(
                    Questiontype.radio.name,
                    style: MyTheme().textfieldtextstyle,
                  ),
                  selected: selectedquestiontype == Questiontype.radio.name,
                  checkmarkColor: Colors.amberAccent,
                  onSelected: (value) {
                    setState(() {
                      selectedquestiontype = Questiontype.radio.name;
                    });
                  },
                ),
                ChoiceChip(
                  color: WidgetStatePropertyAll(Colors.black),
                  label: Text(
                    Questiontype.boolean.name,
                    style: MyTheme().textfieldtextstyle,
                  ),
                  selected: selectedquestiontype == Questiontype.boolean.name,
                  selectedColor: const Color.fromARGB(255, 34, 9, 77),
                  onSelected: (value) {
                    setState(() {
                      selectedquestiontype = Questiontype.boolean.name;
                    });
                  },
                ),
              ],
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  border: BoxBorder.all(color: Colors.white),
                ),
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(20),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OutlinedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              Colors.black,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              if (selectedquestionindex > 0) {
                                selectedquestionindex--;
                                selectedquestiontype =
                                    questions[selectedquestionindex]
                                        .questiontype;
                              }
                            });
                          },
                          child: Text(
                            "Previous",
                            style: MyTheme().textfieldtextstyle,
                          ),
                        ),
                        OutlinedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              const Color.fromARGB(255, 73, 32, 32),
                            ),
                          ),
                          onPressed: () {
                            if (questions.isEmpty) {
                              return;
                            }
                            setState(() {
                              if (questions.length == 1) {
                                selectedquestionindex = 0;
                                questions.clear();
                              } else if (selectedquestionindex <
                                      questions.length &&
                                  selectedquestionindex > 0) {
                                questions.removeAt(selectedquestionindex);
                                selectedquestionindex--;
                                selectedquestiontype =
                                    questions[selectedquestionindex]
                                        .questiontype;
                              }
                            });
                          },
                          child: Text(
                            "Delete",
                            style: MyTheme().textfieldtextstyle,
                          ),
                        ),
                        OutlinedButton(
                          focusNode: addbuttonbuttonfocusnode,
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              Colors.black,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              debugPrint(
                                "$selectedquestionindex, questionslength: ${questions.length}",
                              );
                              if (selectedquestionindex >=
                                  questions.length - 1) {
                                questions.add(
                                  QuestionsData(
                                    question: "",
                                    answers: [],
                                    correctanswerindex: [],
                                    questiontype: selectedquestiontype,
                                  ),
                                );
                                // selectedquestiontype =
                                //     questions[selectedquestionindex]
                                //         .questiontype;
                              }
                              if (questions.length > 1) {
                                selectedquestionindex++;
                                selectedquestiontype =
                                    questions[selectedquestionindex]
                                        .questiontype;
                              }

                              debugPrint(
                                questions[questions.length - 1].questiontype,
                              );
                            });
                          },
                          child: Text(
                            selectedquestionindex >= questions.length - 1
                                ? "ADD"
                                : "Next",
                            style: MyTheme().textfieldtextstyle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    questions.isNotEmpty
                        ? questionrenderselecter()
                        : SizedBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
