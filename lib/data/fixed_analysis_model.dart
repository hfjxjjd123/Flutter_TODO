import 'dart:convert';

/// allCounter : "allCounter"
/// doneCounter : "doneCounter"
/// todo : "todo"
class FixedAnalysisModel {
  late String todo;
  late String key;
  int allCounter=0;
  int doneCounter=0;

  FixedAnalysisModel({required this.todo, required this.key});

  FixedAnalysisModel.fromJson(dynamic json) {
    allCounter = json['allCounter'];
    doneCounter = json['doneCounter'];
    todo = json['todo'];
    key = json['key'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['allCounter'] = allCounter;
    map['doneCounter'] = doneCounter;
    map['todo'] = todo;
    map['key'] = key;
    return map;
  }

  FixedAnalysisModel.fromStringData(String data) :this.fromJson(json.decode(data));
}