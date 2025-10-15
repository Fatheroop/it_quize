import 'package:hive/hive.dart';
part 'testdatahive.g.dart';

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
  Testdatahive({
    required this.testname,
    required this.testtime,
    required this.classno,
    required this.questions,
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

  QuestionsData({
    required this.question,
    required this.answers,
    required this.correctanswerindex,
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
