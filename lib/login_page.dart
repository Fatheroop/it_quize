import 'package:flutter/material.dart';
import 'package:it_quize/main.dart';
import 'package:it_quize/passwordboxhive.dart';
import 'package:it_quize/teacher.dart';
import 'package:it_quize/theme.dart';

List<String> studentClasses = [
  "class_12th",
  "class_11th",
  "class_10th",
  "class_9th",
];

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //box
  final box = Passwordboxhive();
  //declaration
  final focususername = FocusNode();
  var passwordencrypt = true;
  String headinfo = "Enter information";
  //Contoroller
  final usernamecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  //chips
  var selectedclass = studentClasses[0];

  @override
  void initState() {
    if (!box.passwordsbox.containsKey(teachername)) {
      box.passwordsbox.put(teachername, "123");
    }
    debugPrint(box.teacherpassword);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    usernamecontroller.dispose();
    passwordcontroller.dispose();
    focususername.dispose();
  }

  void login() {
    final key = "${usernamecontroller.text}_$selectedclass";
    final userData = box.passwordsbox.get(key);

    if (usernamecontroller.text == teachername &&
        passwordcontroller.text == box.passwordsbox.get(teachername)) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              TeacherScreen(teachername: usernamecontroller.text),
        ),
      );
      usernamecontroller.value = TextEditingValue.empty;
      passwordcontroller.value = TextEditingValue.empty;
    } else if (userData != null && passwordcontroller.text == userData[1]) {
      setState(() {
        headinfo = "Login Successfully";
      });
      usernamecontroller.value = TextEditingValue.empty;
      passwordcontroller.value = TextEditingValue.empty;
      debugPrint("Login Successfully");
    } else {
      setState(() {
        headinfo = "Wrong Username or Password";
      });
      debugPrint("Wrong Username or Password");
    }
  }

  void autofill({String classno = "", String username = ""}) {
    setState(() {
      if (classno.isNotEmpty) {
        selectedclass = classno;
      }
      if (username.isNotEmpty) {
        usernamecontroller.value = TextEditingValue(text: username);
      }
      box.filtervalue = "${username}_$classno";
      box.filter();
    });
  }

  @override
  Widget build(BuildContext context) {
    const gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.10, 0.90],
      colors: [Colors.white, Color.fromARGB(255, 12, 87, 148)],
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Text(
            "Login Page",
            textAlign: TextAlign.center,
            style: MyTheme().textfieldtextstyle.copyWith(
              fontSize: 30,
              fontFamily: "Pacifico",
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login_page_1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              height: 600,
              width: 400,
              child: ListView.builder(
                itemCount: box.keys.length,
                itemBuilder: (context, index) {
                  var keydata = box.keys[index];
                  String name = box.passwordsbox.get(keydata)[0];
                  String classno = box.passwordsbox.get(keydata)[2];
                  return GestureDetector(
                    onTap: () {
                      autofill(classno: classno, username: name);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            name,
                            style: MyTheme().textfieldtextstyle,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Text(
                          classno,
                          style: MyTheme().textfieldtextstyle,
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            SizedBox(
              width: 450,
              height: 800,
              child: Column(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Head
                  Text(headinfo, style: MyTheme().textfieldtextstyle),
                  ClassChoiceChip(
                    selectedclass: selectedclass,
                    callbackfunction: (String selected) {
                      autofill(classno: selected);
                    },
                  ),

                  //UsernameTextField
                  TextField(
                    controller: usernamecontroller,
                    maxLines: 1,
                    focusNode: focususername,
                    style: MyTheme().textfieldtextstyle,
                    onChanged: (value) {
                      if (teachername.startsWith(value)) {
                        return;
                      } else {
                        setState(() {
                          box.filtervalue = value.trim();
                          box.filter();
                          if (box.filtered.length == 1) {
                            usernamecontroller.value = TextEditingValue(
                              text: box.passwordsbox.get(box.filtered[0])[0],
                            );
                          }
                        });
                      }
                    },
                    onEditingComplete: () {
                      setState(() {
                        focususername.nextFocus();
                      });
                    },
                    decoration: InputDecoration(
                      enabledBorder: MyTheme().border,
                      focusedBorder: MyTheme().border,
                      label: Text(
                        "Enter UserName",
                        style: TextStyle(fontSize: 10),
                      ),
                      prefixIcon: Icon(Icons.person_2_outlined),
                    ),
                  ),

                  //PasswordTextFiled
                  TextFormField(
                    obscureText: passwordencrypt,
                    obscuringCharacter: 'X',
                    onChanged: (value) {
                      if (usernamecontroller.text == "" ||
                          usernamecontroller.value == TextEditingValue.empty) {
                        passwordcontroller.value = TextEditingValue.empty;
                      }
                    },
                    controller: passwordcontroller,
                    maxLines: 1,
                    style: MyTheme().textfieldtextstyle,
                    onEditingComplete: () {
                      focususername.nextFocus();
                      login();
                    },
                    decoration: InputDecoration(
                      enabledBorder: MyTheme().border,
                      focusedBorder: MyTheme().border,
                      label: Text(
                        "Enter Password",
                        style: TextStyle(fontSize: 10),
                      ),
                      prefixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            passwordencrypt = !passwordencrypt;
                            debugPrint("State changed");
                          });
                        },
                        child: Icon(Icons.key_outlined),
                      ),
                    ),
                  ),

                  //Login Button
                  TextButton(
                    onPressed: login,
                    child: ShaderMask(
                      shaderCallback: (bounds) {
                        return gradient.createShader(
                          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Login", style: TextStyle(fontSize: 20)),
                      ),
                    ),
                  ),

                  //Comment
                  SizedBox(height: 40),
                  Text(
                    "This picture shows relation between Teacher and student how an teacher helps students to grow or i say to become an complete grown sapling to Tree",
                    textAlign: TextAlign.justify,
                    style: MyTheme().textfieldtextstyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
