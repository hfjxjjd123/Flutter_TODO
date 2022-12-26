import 'package:cloud_firestore/cloud_firestore.dart';

/// allCounter : "allCounter"
/// doneCounter : "doneCounter"
/// todo : "todo"
class FixedAnalysisModel {
  late String todo;
  int allCounter=0;
  int doneCounter=0;

  FixedAnalysisModel({required this.todo});

  FixedAnalysisModel.fromJson(dynamic json) {
    allCounter = json['allCounter'];
    doneCounter = json['doneCounter'];
    todo = json['todo'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['allCounter'] = allCounter;
    map['doneCounter'] = doneCounter;
    map['todo'] = todo;
    return map;
  }

  FixedAnalysisModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> snapshot) :this.fromJson(snapshot.data()!);
  FixedAnalysisModel.fromQuerySnapshot(QueryDocumentSnapshot<Map<String,dynamic>> snapshot) :this.fromJson(snapshot.data());

}