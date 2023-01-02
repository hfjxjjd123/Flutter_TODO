// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:secare/test/test_screen.dart';
// import '../const/fetching_analysis_flag.dart';
// import '../const/mid.dart';
// import '../data/fixed_analysis_model.dart';
// import '../data/task_model.dart';
//
// class AnalysisServiceFixed{
//   static Future createAnalysisFixed(TaskModel taskModel) async{
//     FixedAnalysisModel fixedAnalysisModel = FixedAnalysisModel(
//       todo: taskModel.todo,
//       key: taskModel.key
//     );
//
//     DocumentReference<Map<String, dynamic>> analDocReference = FirebaseFirestore.instance
//         .collection(MID).doc("Analysis")
//         .collection("Fixed").doc(fixedAnalysisModel.todo);
//
//     final DocumentSnapshot documentSnapshot = await analDocReference.get();
//
//     if(!documentSnapshot.exists){
//       await analDocReference.set(fixedAnalysisModel.toJson());
//     } else{
//     }
//   }
//
//   static Future updateAnalysisFixed(String todo,int stat) async{
//     DocumentReference<Map<String, dynamic>> analDocReference = FirebaseFirestore.instance
//         .collection(MID).doc("Analysis")
//         .collection("Fixed").doc(todo);
//
//     final DocumentSnapshot<Map<String, dynamic>> snapshot = await analDocReference.get();
//
//
//
//     if(!snapshot.exists){
//       TaskModel taskModel = TaskModel(todo: todo, isFixed: true);
//       createAnalysisFixed(taskModel);
//       updateAnalysisFixed(todo, stat);
//     } else{
//       FixedAnalysisModel fixedAnalysisModel = FixedAnalysisModel.fromSnapshot(snapshot);
//
//       switch(stat){
//         case ADD_NEW:{
//           fixedAnalysisModel.allCounter++;
//         } break;
//         case DELETE_DO:{
//           fixedAnalysisModel.allCounter--;
//         } break;
//         case DELETE_DONE:{
//           fixedAnalysisModel.doneCounter--;
//           fixedAnalysisModel.allCounter--;
//         } break;
//         case DONE_TO_DO:{
//           fixedAnalysisModel.doneCounter--;
//         } break;
//         case DO_TO_DONE:{
//           fixedAnalysisModel.doneCounter++;
//         } break;
//         case RENAME:break;
//         case READ:break;
//         default: {
//           fixedAnalysisModel.allCounter += stat-MULTIPLE_ADD;
//         }break;
//       }
//
//       await analDocReference.update(fixedAnalysisModel.toJson());
//     }
//
//   }
//
//   static Future<List<FixedAnalysisModel>> readFixedProgress() async {
//     List<FixedAnalysisModel> fixes = [];
//
//     CollectionReference<Map<String, dynamic>> taskColReference = FirebaseFirestore.instance
//         .collection(MID).doc("Analysis")
//         .collection("Fixed");
//
//     final QuerySnapshot<Map<String, dynamic>> snapshot = await taskColReference.get();
//
//     for(DocumentSnapshot<Map<String, dynamic>> documentSnapshot in snapshot.docs){
//       FixedAnalysisModel fixedAnalysisModel = FixedAnalysisModel.fromSnapshot(documentSnapshot);
//       fixes.add(fixedAnalysisModel);
//     }
//
//     return fixes;
//   }
//
//   static Future deleteAnalysisFixed(String todo) async{
//     DocumentReference<Map<String, dynamic>> taskDocReference = FirebaseFirestore.instance
//         .collection(MID).doc("Analysis")
//         .collection("Fixed").doc(todo);
//
//     final DocumentSnapshot documentSnapshot = await taskDocReference.get();
//
//     if(documentSnapshot.exists){
//       await taskDocReference.delete();
//     } else{
//       logger.d("NONE");
//     }
//   }
// }