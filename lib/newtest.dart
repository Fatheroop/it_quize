import 'package:flutter/material.dart';
import 'package:it_quize/main.dart';
import 'package:it_quize/theme.dart';

class Newtest extends StatefulWidget {
  const Newtest({super.key});

  @override
  State<Newtest> createState() => _NewtestState();
}

class _NewtestState extends State<Newtest> {
  final testnamecontroller = TextEditingController();
  var testselectedclass = "";
  var testname = "";
  @override
  void initState() {
    super.initState();
  }

  Widget testdataaltertdialog() {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: const Color.fromARGB(90, 255, 255, 255)),
        borderRadius: BorderRadiusGeometry.all(Radius.circular(8)),
      ),
      backgroundColor: Colors.black12,
      title: Text("Test Data", style: MyTheme().textfieldtextstyle),
      contentPadding: EdgeInsets.all(10),
      content: Column(
        spacing: 12,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClassChoiceChip(
            selectedclass: testselectedclass,
            callbackfunction: (String selected) {
              testselectedclass = selected;
            },
          ),
          TextField(
            onSubmitted: (value) {
              FocusNode().nextFocus();
            },
            style: TextStyle(
              fontFamily: "Lato",
              fontWeight: FontWeight.bold,
              color: Colors.white38,
            ),
            controller: testnamecontroller,
            decoration: InputDecoration(
              label: Text("Enter Test Name"),
              border: MyTheme().border,
            ),
          ),

          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Sumit", style: MyTheme().textfieldtextstyle),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Text(
            "New Test Screen",
            textAlign: TextAlign.center,
            style: MyTheme().textfieldtextstyle.copyWith(
              fontSize: 30,
              fontFamily: "Pacifico",
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/images/newtest_background.jpg"),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 70),
            Row(
              children: [
                OutlinedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => testdataaltertdialog(),
                      animationStyle: AnimationStyle(
                        duration: Durations.extralong1,
                        curve: Curves.elasticInOut,
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
                TextField(
                  decoration: InputDecoration(
                    border: MyTheme().border,
                    label: Text(
                      "Enter text Name to filter",
                      style: MyTheme().textfieldtextstyle,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
