// ignore: file_names
import 'package:flutter/material.dart';
import 'package:it_quize/passwordboxhive.dart';
import 'package:it_quize/studentmanage.dart';
import 'package:it_quize/theme.dart';

class TeacherScreen extends StatefulWidget {
  final String teachername;
  const TeacherScreen({super.key, required this.teachername});

  @override
  State<TeacherScreen> createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  var passworddailogboxshow = false;

  final List<IconData> optionsicons = [
    Icons.person_2_outlined,
    Icons.pages_outlined,
    Icons.newspaper_outlined,
    Icons.key_off_rounded,
    Icons.pending,
    Icons.pages,
  ];
  final List<String> optiionstext = [
    "Student Manage",
    "Test Manage",
    "Create New Test",
    "Change Password",
    "Pending Tests",
    "Completed Test",
  ];

  final List<Widget> screens = [Studentmanage()];

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
            "Teacher Page",
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
            image: AssetImage("assets/images/teacher_background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
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
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 200,
                  crossAxisSpacing: 10,
                  crossAxisCount: 3,
                ),
                itemCount: optionsicons.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 20,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (optiionstext[index] == "Change Password") {
                            passworddailogboxshow = !passworddailogboxshow;
                          } else {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return screens[0];
                                },
                              ),
                            );
                          }
                        });
                      },
                      child: Card.outlined(
                        color: const Color.fromARGB(56, 0, 0, 0),
                        elevation: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 20),
                            Icon(optionsicons[index], color: Colors.white),
                            SizedBox(height: 10),
                            Text(
                              optiionstext[index],
                              style: TextStyle(
                                color: MyTheme().textfieldtextcolor,
                              ),
                            ),
                          ],
                        ),
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

class Changepassword extends StatefulWidget {
  final VoidCallback callbackclose;
  const Changepassword({super.key, required this.callbackclose});

  @override
  State<Changepassword> createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {
  final box = Passwordboxhive();
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
