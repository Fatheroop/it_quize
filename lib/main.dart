import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:it_quize/login_page.dart';
import 'package:it_quize/testdata.dart';
import 'package:it_quize/theme.dart';
import 'package:window_manager/window_manager.dart';
import 'package:path_provider/path_provider.dart';

final teachername = "sarikamam";
final defaultpassword = "Anya Forger";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var dir = await getApplicationDocumentsDirectory();
  debugPrint("Path is : ${dir.path}");
  Hive.init(dir.path);
  Hive.registerAdapter(TestdatahiveAdapter());
  Hive.registerAdapter(QuestionsDataAdapter());
  Hive.registerAdapter(StudentTestDataAdapter());
  await windowManager.ensureInitialized();
  windowManager.setFullScreen(true);
  windowManager.setAlwaysOnTop(false);
  await Hive.openBox("students");
  await Hive.openBox<Testdatahive>("test");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoginPage());
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
    selected = widget.selectedclass;
    return SizedBox(
      height: 60,
      width: 600,
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: studentClasses.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ChoiceChip(
              color: WidgetStatePropertyAll(Colors.black),
              checkmarkColor: Colors.blue,
              label: Text(
                studentClasses[index],
                style: MyTheme().textfieldtextstyle,
              ),
              selected: studentClasses[index] == selected,
              onSelected: (value) {
                setState(() {
                  selected = studentClasses[index];
                  widget.callbackfunction(selected);
                });
              },
            ),
          );
        },
      ),
    );
  }
}
