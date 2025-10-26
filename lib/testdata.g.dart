// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'testdata.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TestdatahiveAdapter extends TypeAdapter<Testdatahive> {
  @override
  final int typeId = 0;

  @override
  Testdatahive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Testdatahive(
      testname: fields[0] as String,
      testtime: fields[1] as int,
      classno: fields[2] as String,
      questions: (fields[3] as List).cast<QuestionsData>(),
      testtype: fields[5] as String?,
    )..studentdata = (fields[4] as List).cast<StudentTestData>();
  }

  @override
  void write(BinaryWriter writer, Testdatahive obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.testname)
      ..writeByte(1)
      ..write(obj.testtime)
      ..writeByte(2)
      ..write(obj.classno)
      ..writeByte(3)
      ..write(obj.questions)
      ..writeByte(4)
      ..write(obj.studentdata)
      ..writeByte(5)
      ..write(obj.testtype);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestdatahiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class QuestionsDataAdapter extends TypeAdapter<QuestionsData> {
  @override
  final int typeId = 1;

  @override
  QuestionsData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestionsData(
      question: fields[0] as String,
      answers: (fields[1] as List).cast<String>(),
      correctanswerindex: (fields[2] as List).cast<int>(),
      questiontype: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, QuestionsData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.question)
      ..writeByte(1)
      ..write(obj.answers)
      ..writeByte(2)
      ..write(obj.correctanswerindex)
      ..writeByte(3)
      ..write(obj.questiontype);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionsDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StudentTestDataAdapter extends TypeAdapter<StudentTestData> {
  @override
  final int typeId = 2;

  @override
  StudentTestData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentTestData(
      studentname: fields[0] as String,
      studentclass: fields[1] as String,
      timetaken: fields[2] as int,
      obtainedmarks: fields[3] as int,
      questiondata: (fields[4] as List).cast<QuestionsData>(),
    );
  }

  @override
  void write(BinaryWriter writer, StudentTestData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.studentname)
      ..writeByte(1)
      ..write(obj.studentclass)
      ..writeByte(2)
      ..write(obj.timetaken)
      ..writeByte(3)
      ..write(obj.obtainedmarks)
      ..writeByte(4)
      ..write(obj.questiondata);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentTestDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
