import 'package:cloud_firestore/cloud_firestore.dart';

/// day : "day"
/// todo : "todo"
/// isDone : "isDone"
/// stuffId : "stuffId"

class StuffModel {
  late String day;
  late String todo;
  bool isDone = false;
  late String stuffId;

  StuffModel({
    required this.day,
    required this.todo,
    required this.stuffId,});

  StuffModel.fromJson(dynamic json) {
    day = json['day'];
    todo = json['todo'];
    isDone = json['isDone'];
    stuffId = json['stuffId'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day'] = day;
    map['todo'] = todo;
    map['isDone'] = isDone;
    map['stuffId'] = stuffId;
    return map;
  }

  StuffModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> snapshot) :this.fromJson(snapshot.data()!);
  StuffModel.fromQuerySnapshot(QueryDocumentSnapshot<Map<String,dynamic>> snapshot) :this.fromJson(snapshot.data());

}

