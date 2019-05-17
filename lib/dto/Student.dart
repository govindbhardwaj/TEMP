import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class Student {
  String studentId;
  String studentName;
  int studentScores;

  Student({this.studentId, this.studentName, this.studentScores});

  factory Student.fromJson(Map<String, dynamic> parsedJson) {
    return Student(
        studentId: parsedJson['id'],
        studentName: parsedJson['name'],
        studentScores: parsedJson['score']);
  }
}

Future<String> _loadAStudentAsset() async {
  return await rootBundle.loadString('assets/data.json');
}

Future<Student> loadStudent() async {
  //await wait(5);
  String jsonString = await _loadAStudentAsset();
  final jsonResponse = json.decode(jsonString);
  return new Student.fromJson(jsonResponse);
}


Future wait(int seconds) {
  return new Future.delayed(Duration(seconds: seconds), () => {});
}
