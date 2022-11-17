import 'package:cloud_firestore/cloud_firestore.dart';

/// name : "name"
/// job : "job"

class ProfileModel {
  late String name;
  late String job;

  ProfileModel({
    required this.name,
    required this.job,
  });

  ProfileModel.fromJson(dynamic json) {
    name = json['name'];
    job = json['job'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['job'] = job;
    return map;
  }

  ProfileModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> snapshot) :this.fromJson(snapshot.data()!);
  ProfileModel.fromQuerySnapshot(QueryDocumentSnapshot<Map<String,dynamic>> snapshot) :this.fromJson(snapshot.data());

}

