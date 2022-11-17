import 'package:cloud_firestore/cloud_firestore.dart';

/// allCounter : "allCounter"
/// doneCounter : "doneCounter"
class AccumulateAnalysisModel {
  int allCounter=0;
  int doneCounter=0;

  AccumulateAnalysisModel();

  AccumulateAnalysisModel.fromJson(dynamic json) {
    allCounter = json['allCounter'];
    doneCounter = json['doneCounter'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['allCounter'] = allCounter;
    map['doneCounter'] = doneCounter;
    return map;
  }

  AccumulateAnalysisModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> snapshot) :this.fromJson(snapshot.data()!);
  AccumulateAnalysisModel.fromQuerySnapshot(QueryDocumentSnapshot<Map<String,dynamic>> snapshot) :this.fromJson(snapshot.data());

}