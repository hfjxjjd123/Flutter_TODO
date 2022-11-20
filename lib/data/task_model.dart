import 'package:cloud_firestore/cloud_firestore.dart';

/// todo : "todo"
/// isDone : "isDone"
/// isFixed : "isFixed"

class TaskModel {
  late String todo;
  late bool isFixed;
  bool isDone = false;

  TaskModel({
    required this.todo,
    required this.isFixed
    ,});

  TaskModel.fromJson(dynamic json) {
    todo = json['todo'];
    isDone = json['isDone'];
    isFixed = json['isFixed'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['todo'] = todo;
    map['isDone'] = isDone;
    map['isFixed'] = isFixed;
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

  TaskModelForProfile.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> snapshot) :this.fromJson(snapshot.data()!);
  TaskModelForProfile.fromQuerySnapshot(QueryDocumentSnapshot<Map<String,dynamic>> snapshot) :this.fromJson(snapshot.data());

}



