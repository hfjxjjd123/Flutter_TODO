import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secare/test/test_screen.dart';
import '../const/mid.dart';
import '../data/task_model.dart';

class DTaskService{
  static Future writeTask(TaskModel taskModel) async{
    DocumentReference<Map<String, dynamic>> taskDocReference = FirebaseFirestore.instance
        .collection(MID).doc("DailyTask")
        .collection('tasks').doc(taskModel.todo);

    final DocumentSnapshot documentSnapshot = await taskDocReference.get();

    if(!documentSnapshot.exists){
      await taskDocReference.set(taskModel.toJson());
    }
  }

  static Future updateTask(TaskModel taskModel) async{
    DocumentReference<Map<String, dynamic>> TaskDocReference = FirebaseFirestore.instance
        .collection(MID).doc("DailyTask")
        .collection('tasks').doc(taskModel.todo);

    final DocumentSnapshot documentSnapshot = await TaskDocReference.get();

    if(!documentSnapshot.exists){
      logger.d("not exist!"); // 수정요함
    } else {
      await TaskDocReference.update(taskModel.toJson());
    }
  }

//수정과 생성을 나누면?//수정은 바뀐 onCOunt값을?

  static Future<List<TaskModel>> readTasks(String day) async{
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

  static Future<void> deleteTask(TaskModel taskModel) async{
    DocumentReference<Map<String, dynamic>> docReference = FirebaseFirestore.instance
        .collection(MID).doc("DailyTask")
        .collection('tasks').doc(taskModel.todo);

    final DocumentSnapshot documentSnapshot = await docReference.get();

    if(documentSnapshot.exists){
      await docReference.delete();
    } else{
      print("there is no such data model"); //수정요함
    }
  } // test this code in home


}