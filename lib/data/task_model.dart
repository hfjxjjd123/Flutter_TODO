import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

/// todo : "todo"
/// isDone : "isDone"
/// isFixed : "isFixed"
/// key: "key"
Random _rnd = Random();

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
String generateRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

class TaskModel {
  late String todo;
  late bool isFixed;
  bool isDone = false;
  String key = generateRandomString(10);

  TaskModel({
    required this.todo,
    required this.isFixed
    ,});

  TaskModel.fromJson(dynamic json) {
    todo = json['todo'];
    isDone = json['isDone'];
    isFixed = json['isFixed'];
    key = json['key'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['todo'] = todo;
    map['isDone'] = isDone;
    map['isFixed'] = isFixed;
    map['key'] = key;
    return map;
  }

  TaskModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> snapshot) :this.fromJson(snapshot.data()!);
  TaskModel.fromQuerySnapshot(QueryDocumentSnapshot<Map<String,dynamic>> snapshot) :this.fromJson(snapshot.data());

}

/// todo : "todo"
class TaskModelForProfile {
  late String todo;

  TaskModelForProfile({required this.todo,});

  TaskModelForProfile.fromJson(dynamic json) {
    todo = json['todo'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['todo'] = todo;
    return map;
  }

  TaskModelForProfile.fromStringData(String data) :this.fromJson(json.decode(data));
  TaskModelForProfile.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> snapshot) :this.fromJson(snapshot.data()!);
  TaskModelForProfile.fromQuerySnapshot(QueryDocumentSnapshot<Map<String,dynamic>> snapshot) :this.fromJson(snapshot.data());

}



