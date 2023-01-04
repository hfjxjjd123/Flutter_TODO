import 'dart:convert';
/// allCounter : "allCounter"
/// doneCounter : "doneCounter"
/// date : "date"
class DailyAnalysisModel {
  int allCounter = 0;
  int doneCounter = 0;
  late String date;

  DailyAnalysisModel({
    required this.date,
    required this.allCounter,
    required this.doneCounter
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

  DailyAnalysisModel.fromStringData(String data) :this.fromJson(json.decode(data));

}