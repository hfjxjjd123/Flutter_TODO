import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secare/repo/analysis_service_daily.dart';
import 'package:secare/test/test_screen.dart';
import '../const/mid.dart';
import '../data/task_model.dart';
import 'analysis_accumulate.dart';
import 'analysis_service_fixed.dart';

class DTaskService{
  static Future writeTask(TaskModel taskModel) async{
    logger.d("Why? 왜 안돼? ${taskModel.todo}");
    DocumentReference<Map<String, dynamic>> taskDocReference = FirebaseFirestore.instance
        .collection(MID).doc("DailyTask")
        .collection('tasks').doc(taskModel.todo);

    final DocumentSnapshot documentSnapshot = await taskDocReference.get();

    if(!documentSnapshot.exists){
      await taskDocReference.set(taskModel.toJson());
    }
  }

  static Future updateTask(String todo, bool isFixed) async{
    DocumentReference<Map<String, dynamic>> TaskDocReference = FirebaseFirestore.instance
        .collection(MID).doc("DailyTask")
        .collection('tasks').doc(todo);

    TaskModel taskModel = TaskModel(todo: todo, isFixed: isFixed);

    final DocumentSnapshot documentSnapshot = await TaskDocReference.get();

    if(!documentSnapshot.exists){
      logger.d("not exist!"); // 수정요함
    } else {
      await TaskDocReference.update(taskModel.toJson());
    }
  }

  static Future updateTaskDone(String todo) async{

    logger.d("updateTaskDone() 호출");

    DocumentReference<Map<String, dynamic>> TaskDocReference = FirebaseFirestore.instance
        .collection(MID).doc("DailyTask")
        .collection('tasks').doc(todo);

    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await TaskDocReference.get();

    if(!documentSnapshot.exists){
      logger.d("not exist!"); // 수정요함
    } else {
      TaskModel taskModel = TaskModel.fromSnapshot(documentSnapshot);
      taskModel.isDone = !taskModel.isDone;
      await TaskDocReference.update(taskModel.toJson());

      int stat = (taskModel.isDone)?4:3;
      await AnalysisServiceDaily.updateAnalysisDaily(stat);
      await AnalysisAccumulate.updateAnalysisAccumulate(stat);

      if(taskModel.isFixed == true){
        await AnalysisServiceFixed.updateAnalysisFixed(todo, stat);
      }
    }
  }

  //중복체크 수정요망

//수정과 생성을 나누면?//수정은 바뀐 onCOunt값을?

  static Future<List<TaskModel>> readTasks() async{

    CollectionReference<Map<String,dynamic>> collectionReference =  FirebaseFirestore.instance
        .collection(MID).doc("DailyTask")
        .collection('tasks');
    QuerySnapshot<Map<String, dynamic>> snapshots = await collectionReference.get();

    List<TaskModel> tasks = [];

    for(int i=0; i<snapshots.size ; i++){
      TaskModel taskModel = TaskModel.fromQuerySnapshot(snapshots.docs[i]);
      tasks.add(taskModel);
    }

    return tasks;
  }

  static Future<void> deleteTask(String key) async{
    DocumentReference<Map<String, dynamic>> docReference = FirebaseFirestore.instance
        .collection(MID).doc("DailyTask")
        .collection('tasks').doc(key);

    final DocumentSnapshot documentSnapshot = await docReference.get();

    if(documentSnapshot.exists){
      await docReference.delete();
    } else{
      print("there is no such data model"); //수정요함
    }
  } // test this code in home

  static Future<void> clearDay() async{
    CollectionReference<Map<String, dynamic>> collectionReference = FirebaseFirestore.instance
        .collection(MID).doc("DailyTask")
        .collection('tasks');

    final QuerySnapshot<Map<String, dynamic>> snapshot = await collectionReference.get();

    for(DocumentSnapshot documentSnapshot in snapshot.docs){
      documentSnapshot.reference.delete();
    }
  }


}