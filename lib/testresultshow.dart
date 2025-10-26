import 'package:flutter/material.dart';
import 'package:it_quize/testdata.dart';
import 'package:it_quize/theme.dart';

class ResultHome extends StatefulWidget {
  final String testid;
  const ResultHome({super.key, required this.testid});

  @override
  State<ResultHome> createState() => _ResultHomeState();
}

class _ResultHomeState extends State<ResultHome> {
  final List<StudentTestData> studentdata = [];
  final testbox = Testdatamanage().testbox;
  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() {
    studentdata.clear();
    final Testdatahive? data = testbox.get(widget.testid);
    studentdata.addAll(data!.studentdata);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("${studentdata.length}");
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: MyTheme().appBar("Student Data"),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/images/testmanage_background.jpg"),
          ),
        ),
        child: ListView.builder(
          itemCount: studentdata.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Name: ${studentdata[index].studentname}",
                    style: MyTheme().textfieldtextstyle,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            final test = testbox.get(widget.testid);
                            test!.studentdata.remove(studentdata[index]);
                            test.save();
                            refresh();
                          });
                        },
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                      ),
                      SizedBox(width: 10),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => Resultpreview(
                                testid: widget.testid,
                                studentdata: studentdata[index],
                              ),
                            ),
                          );
                        },
                        icon: Icon(Icons.preview),
                        color: Colors.green,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class Resultpreview extends StatelessWidget {
  final String testid;
  final StudentTestData studentdata;
  final List<QuestionsData> testquestions = [];
  Resultpreview({super.key, required this.testid, required this.studentdata}) {
    testquestions.addAll(Testdatamanage().testbox.get(testid)!.questions);
  }

  // There are there colors red green blue
  // red is if correctionindex from student didn't contain in testquestion correctindex
  // green if correctionindex is contained by testquestion correctindex
  // blue if correctionindex didnt' contained by testquestion correctindex

  Color optioncolorselection(int quesitonindex, int answerindex) {
    if (studentdata.questiondata[quesitonindex].correctanswerindex.contains(
          answerindex,
        ) ||
        testquestions[quesitonindex].correctanswerindex.contains(answerindex)) {
      if (studentdata.questiondata[quesitonindex].correctanswerindex.contains(
            answerindex,
          ) &&
          !testquestions[quesitonindex].correctanswerindex.contains(
            answerindex,
          )) {
        return Colors.red;
      } else if (studentdata.questiondata[quesitonindex].correctanswerindex
              .contains(answerindex) &&
          testquestions[quesitonindex].correctanswerindex.contains(
            answerindex,
          )) {
        return Colors.green;
      } else {
        return Colors.blue;
      }
    }
    return Colors.white;
  }

  Widget questionrender(final int index) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(11, 255, 255, 255),
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: const Color.fromARGB(165, 97, 97, 97)),
        shape: BoxShape.rectangle,
      ),
      child: Column(
        children: [
          Text(
            "Question: ${studentdata.questiondata[index].question}",
            style: MyTheme().textfieldtextstyle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            itemCount: studentdata.questiondata[index].answers.length,
            itemBuilder: (context, index0) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  studentdata.questiondata[index].answers[index0],
                  textAlign: TextAlign.start,
                  style: MyTheme().textfieldtextstyle.copyWith(
                    color: optioncolorselection(index, index0),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: MyTheme().appBar("Result Preview"),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            opacity: 0.3,
            fit: BoxFit.cover,
            image: AssetImage("assets/images/result_background.jpg"),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Student Name: ${studentdata.studentname}",
                  style: MyTheme().textfieldtextstyle.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Class: ${studentdata.studentclass}",
                  style: MyTheme().textfieldtextstyle.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Marks Obtained: ${studentdata.obtainedmarks}",
                  style: MyTheme().textfieldtextstyle.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Time Taken: ${studentdata.timetaken}",
                  style: MyTheme().textfieldtextstyle.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              "Description: Red color shows if answers are answerd wrong Green color shows if answers are answered correctly and blue color shows which one is correct answer",
              style: TextStyle(
                color: Colors.red,
                fontFamily: "Lato",
                fontSize: 10,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: studentdata.questiondata.length,
                itemBuilder: (context, index) {
                  return questionrender(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
