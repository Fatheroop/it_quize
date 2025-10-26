import 'package:hive/hive.dart';
part 'testdata.g.dart';

const testtype = ["Quize", "Test"];

@HiveType(typeId: 0)
class Testdatahive extends HiveObject {
  @HiveField(0)
  String testname;
  @HiveField(1)
  int testtime;
  @HiveField(2)
  String classno;
  @HiveField(3)
  List<QuestionsData> questions;
  @HiveField(4)
  List<StudentTestData> studentdata = [];
  @HiveField(5)
  String? testtype;
  Testdatahive({
    required this.testname,
    required this.testtime,
    required this.classno,
    required this.questions,
    required this.testtype,
  });
}

@HiveType(typeId: 1)
class QuestionsData extends HiveObject {
  @HiveField(0)
  String question;
  @HiveField(1)
  List<String> answers;
  @HiveField(2)
  List<int> correctanswerindex;
  @HiveField(3)
  String questiontype;

  QuestionsData({
    required this.question,
    required this.answers,
    required this.correctanswerindex,
    required this.questiontype,
  });
}

@HiveType(typeId: 2)
class StudentTestData extends HiveObject {
  @HiveField(0)
  String studentname;
  @HiveField(1)
  String studentclass;
  @HiveField(2)
  int timetaken;
  @HiveField(3)
  int obtainedmarks;
  @HiveField(4)
  List<QuestionsData> questiondata;

  StudentTestData({
    required this.studentname,
    required this.studentclass,
    required this.timetaken,
    required this.obtainedmarks,
    required this.questiondata,
  });
}

class Testdatamanage {
  final testbox = Hive.box<Testdatahive>("test");
  bool checktestpreexist(String id) {
    if (testbox.keys.contains(id.toLowerCase())) {
      return true;
    } else {
      return false;
    }
  }

  void updatetest(String oldkey, String newkey, Testdatahive data) {
    data.studentdata.addAll(testbox.get(oldkey)!.studentdata);
    testbox.put(newkey, data);
    testbox.delete(oldkey);
  }

  void addtest(Testdatahive data) {
    testbox.put("${data.testname.toLowerCase()}_${data.classno}", data);
  }
}
