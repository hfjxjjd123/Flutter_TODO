import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secare/test/test_screen.dart';
import '../const/mid.dart';
import '../data/profile_model.dart';
import '../data/task_model.dart';

class ProfileService{
  static Future<ProfileModel> readProfile() async{

    DocumentReference<Map<String,dynamic>> documentReference =  FirebaseFirestore.instance
        .collection(MID).doc("Profile");

    DocumentSnapshot<Map<String, dynamic>> snapshot = await documentReference.get();

    if(!snapshot.exists){
      logger.d("그런거 없습니다");
    }
    ProfileModel profileModel = ProfileModel.fromSnapshot(snapshot);
    return profileModel;
  }

  static Future updateProfile(ProfileModel profileModel) async{
    DocumentReference<Map<String, dynamic>> taskDocReference = FirebaseFirestore.instance
        .collection(MID).doc("Profile");

    final DocumentSnapshot documentSnapshot = await taskDocReference.get();

    if(!documentSnapshot.exists){
      await taskDocReference.set(profileModel.toJson());
    }
  }

  static Future addFixedTaskToProfile(String todo) async{
    TaskModelForProfile taskModelForProfile = TaskModelForProfile(todo: todo);

    DocumentReference<Map<String, dynamic>> taskDocReference = FirebaseFirestore.instance
        .collection(MID).doc("Profile")
        .collection("FixedTasks").doc(taskModelForProfile.todo);

    final DocumentSnapshot documentSnapshot = await taskDocReference.get();

    if(!documentSnapshot.exists){
      await taskDocReference.set(taskModelForProfile.toJson());
    } else{
      await taskDocReference.update(taskModelForProfile.toJson());
    }
  }

  static Future deleteFixedTaskToProfile(TaskModelForProfile taskModelForProfile) async{
    DocumentReference<Map<String, dynamic>> taskDocReference = FirebaseFirestore.instance
        .collection(MID).doc("Profile")
        .collection("FixedTasks").doc(taskModelForProfile.todo);

    final DocumentSnapshot documentSnapshot = await taskDocReference.get();

    if(documentSnapshot.exists){
      await taskDocReference.delete();
    } else{
      logger.d("NONE");
    }
  }



  // static Future updateAchievement(AchieveModel achieveModel) async{
  //   DocumentReference<Map<String, dynamic>> TaskDocReference = FirebaseFirestore.instance
  //       .collection(MID).doc("Proflie")
  //       .collection('Achievement').doc(achieveModel.name);
  //
  //   final DocumentSnapshot documentSnapshot = await TaskDocReference.get();
  //
  //   if(!documentSnapshot.exists){
  //     logger.d("not exist!"); // 수정요함
  //   } else {
  //     await TaskDocReference.update(achieveModel.toJson());
  //   }
  // }

}