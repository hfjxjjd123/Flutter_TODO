import 'dart:convert';

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

  AccumulateAnalysisModel.fromStringData(String data) :this.fromJson(json.decode(data));

}