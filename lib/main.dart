import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:it_quize/login_page.dart';
import 'package:it_quize/newtest.dart';
import 'package:it_quize/testdatahive.dart';
import 'theme.dart';
import 'package:window_manager/window_manager.dart';
import 'package:path_provider/path_provider.dart';

final teachername = "sarikamam";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(TestdatahiveAdapter());
  Hive.registerAdapter(QuestionsDataAdapter());
  Hive.registerAdapter(StudentTestDataAdapter());
  await windowManager.ensureInitialized();
  windowManager.setFullScreen(true);
  windowManager.setAlwaysOnTop(false);
  await Hive.openBox('passwords');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Newtest());
  }
}

class ClassChoiceChip extends StatefulWidget {
  final String selectedclass;
  final Function(String selectedclass) callbackfunction;
  const ClassChoiceChip({
    super.key,
    required this.selectedclass,
    required this.callbackfunction,
  });

  @override
  State<ClassChoiceChip> createState() => _ClassChoiceChipState();
}

class _ClassChoiceChipState extends State<ClassChoiceChip> {
  var selected = "";
  @override
  Widget build(BuildContext context) {
    if (selected == "") {
      selected = widget.selectedclass;
    }

    return SizedBox(
      width: 600,
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: studentClasses.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ChoiceChip(
              checkmarkColor: Colors.blue,
              selectedColor: const Color.fromARGB(220, 0, 0, 0),
              backgroundColor: const Color.fromARGB(255, 30, 30, 30),
              selected: selected == studentClasses[index],
              onSelected: (value) {
                setState(() {
                  selected = studentClasses[index];
                  widget.callbackfunction(selected);
                });
              },
              label: Text(
                studentClasses[index],
                style: MyTheme().textfieldtextstyle,
              ),
            ),
          );
        },
      ),
    );
  }
}
