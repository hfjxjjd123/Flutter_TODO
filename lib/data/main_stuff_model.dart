/// day : "day"
/// todo : "todo"
/// isDone : "isDone"
/// stuffId : "stuffId"

class MainStuffModel {
  MainStuffModel({
    this.day,
    required this.todo,
    this.isDone,
    this.stuffId,});

  MainStuffModel.fromJson(dynamic json) {
    day = json['day'];
    todo = json['todo'];
    isDone = json['isDone'];
    stuffId = json['stuffId'];
  }
  String? day;
  String? todo;
  bool? isDone = false;
  String? stuffId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day'] = day;
    map['todo'] = todo;
    map['isDone'] = isDone;
    map['stuffId'] = stuffId;
    return map;
  }

}