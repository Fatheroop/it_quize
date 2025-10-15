import 'package:flutter/material.dart';
import 'package:it_quize/main.dart';
import 'package:it_quize/passwordboxhive.dart';
import 'login_page.dart';
import 'theme.dart';

class Studentmanage extends StatefulWidget {
  const Studentmanage({super.key});

  @override
  State<Studentmanage> createState() => _StudentmanageState();
}

class _StudentmanageState extends State<Studentmanage> {
  final filtercontroller = TextEditingController();
  final box = Passwordboxhive();
  var filterclass = studentClasses[0];

  @override
  void initState() {
    // box.passwordsbox.clear();
    // box.add(name: "yogesh", classno: studentClasses[0]);
    // box.add(name: "manish", classno: studentClasses[1]);
    // box.add(name: "suresh", classno: studentClasses[1]);
    // box.add(name: "rajesh", classno: studentClasses[0]);
    super.initState();
    debugPrint(box.keys.length.toString());
    debugPrint("hello mike");
    debugPrint("hello mic");
  }

  void autofilter({String classno = "", String filtertext = ""}) {
    setState(() {
      if (classno.isNotEmpty && filtertext.isEmpty) {
        filterclass = classno;
        box.filtervalue = "${filtercontroller.text}_$classno";
        debugPrint(box.filtervalue);
      } else {
        box.filtervalue = filtercontroller.text.toLowerCase();
        debugPrint(box.filtervalue);
      }
      box.filter();
    });
  }

  @override
  Widget build(BuildContext context) {
    const double textfiledwidth = 300;
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
            "Student Manage",
            textAlign: TextAlign.center,
            style: MyTheme().textfieldtextstyle.copyWith(
              fontSize: 30,
              fontFamily: "Pacifico",
            ),
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            opacity: 0.5,
            fit: BoxFit.cover,
            image: AssetImage("assets/images/background_studentmanage.jpg"),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 70),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              spacing: 10,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      var name = "untitled${box.passwordsbox.keys.length + 1}";
                      var classnoe = filterclass;
                      box.add(name: name, classno: filterclass);
                      box.filtervalue = "${name}_$classnoe";
                      box.filter();
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.black26),
                  ),
                  child: Text(
                    "Add Student",
                    style: MyTheme().textfieldtextstyle,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      box.filtervalue = "c";
                      box.filter();
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.black26),
                  ),
                  child: Text(
                    "All Students",
                    style: MyTheme().textfieldtextstyle,
                  ),
                ),

                SizedBox(
                  width: 300,
                  child: TextField(
                    style: MyTheme().textfieldtextstyle,
                    controller: filtercontroller,
                    decoration: InputDecoration(
                      label: Text("FilterName"),
                      prefix: Text("Name: "),
                      border: MyTheme().border,
                    ),
                    onChanged: (value) {
                      setState(() {
                        autofilter(filtertext: value);
                      });
                    },
                  ),
                ),
                ClassChoiceChip(
                  selectedclass: "",
                  callbackfunction: (String selected) {
                    autofilter(classno: selected);
                  },
                ),
              ],
            ),
            SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: box.keys.length,
                itemBuilder: (context, index) {
                  final namecontroller = TextEditingController();
                  var key = box.keys[index];
                  namecontroller.value = TextEditingValue(
                    text: box.passwordsbox.get(key)[0],
                  );
                  var selectedclass = box.passwordsbox.get(key)[2];
                  return Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.all(8),
                    color: const Color.fromARGB(64, 19, 19, 19),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: textfiledwidth,
                          child: TextField(
                            decoration: InputDecoration(
                              prefix: Text(
                                "User Name: ",
                                style: MyTheme().textfieldtextstyle,
                              ),
                              border: MyTheme().border,
                            ),
                            controller: namecontroller,
                            onSubmitted: (value) {
                              box.updatedata(key, value, selectedclass);
                            },
                            style: MyTheme().textfieldtextstyle,
                          ),
                        ),
                        SizedBox(width: 20),
                        ClassChoiceChip(
                          selectedclass: selectedclass,
                          callbackfunction: (String selected) {
                            box.updatedata(
                              key,
                              namecontroller.text,
                              selectedclass,
                            );
                          },
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (!box.passwordsbox.containsKey(
                                "${namecontroller.text.toLowerCase()}_$selectedclass",
                              )) {
                                box.updatedata(
                                  key,
                                  namecontroller.text,
                                  selectedclass,
                                );
                              }
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              Colors.black87,
                            ),
                          ),
                          child: Text("Update"),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            box.passwordsbox.delete(key);
                            setState(() {
                              box.filter();
                            });
                          },
                          child: Text("Remove Student"),
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
