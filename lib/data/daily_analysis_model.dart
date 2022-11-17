import 'package:cloud_firestore/cloud_firestore.dart';

/// allCounter : "allCounter"
/// doneCounter : "doneCounter"
/// date : "date"
class DailyAnalysisModel {
  int allCounter = 0;
  int doneCounter = 0;
  late String date;

  DailyAnalysisModel({
    required this.date
  });

  DailyAnalysisModel.fromJson(dynamic json) {
    allCounter = json['allCounter'];
    doneCounter = json['doneCounter'];
    date = json['date'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['allCounter'] = allCounter;
    map['doneCounter'] = doneCounter;
    map['date'] = date;
    return map;
  }

  DailyAnalysisModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> snapshot) :this.fromJson(snapshot.data());
  DailyAnalysisModel.fromQuerySnapshot(QueryDocumentSnapshot<Map<String,dynamic>> snapshot) :this.fromJson(snapshot.data());

}