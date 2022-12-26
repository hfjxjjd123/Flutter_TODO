// import 'dart:convert';
// import 'dart:io';
// import 'dart:math';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:secare/test/test_screen.dart';
// import '../const/fetching_analysis_flag.dart';
// import '../const/mid.dart';
// import '../data/fixed_analysis_model.dart';
// import '../data/task_model.dart';
//
// class AnalysisFixed{
//
//   static Future<String> get _localPath async {
//     final directory = await getApplicationDocumentsDirectory();
//
//     return directory.path;
//   }
//
//   static Future<File> get _localFile async {
//     final path = await _localPath;
//     return File('$path/analysis_fixed.txt');
//   }
//
//   static Future createAnalysisFixed(TaskModel taskModel) async{
//
//     List<dynamic> fixedModel = [];
//     fixedModel.add(taskModel.todo);
//     fixedModel.add(0);
//     fixedModel.add(0);
//
//     List<List<dynamic>> list;
//     final file = await _localFile;
//
//     try{
//       list = json.decode(await file.readAsString()).cast<List<dynamic>>().toList();
//       list.add(fixedModel);
//     } catch(e){
//       list = [];
//       list.add(fixedModel);
//     }
//
//     return file.writeAsString(json.encode(list.toString()));
//   }
//
//   static Future<File> updateAnalysisFixed(String todo,int stat) async{
//     List<FixedAnalysisModel> list;
//     final file = await _localFile;
//
//       if(stat == ADD_NEW){
//         await createAnalysisFixed(TaskModel(todo: todo, isFixed: true));
//       }
//       logger.d(" 잠만 체크해보자 ---- " + await file.readAsString());
//       list = json.decode(await file.readAsString()).cast<FixedAnalysisModel>().toList();
//
//         for(FixedAnalysisModel fixedAnalysisModel in list){
//           if(fixedAnalysisModel.todo == todo){
//
//             switch(stat){
//               case ADD_NEW:{
//                 fixedAnalysisModel.allCounter++;
//               } break;
//               case DELETE_DO:{
//                 fixedAnalysisModel.allCounter--;
//               } break;
//               case DELETE_DONE:{
//                 fixedAnalysisModel.doneCounter--;
//                 fixedAnalysisModel.allCounter--;
//               } break;
//               case DONE_TO_DO:{
//                 fixedAnalysisModel.doneCounter--;
//               } break;
//               case DO_TO_DONE:{
//                 fixedAnalysisModel.doneCounter++;
//               } break;
//               case RENAME:break;
//               case READ:break;
//               default: {
//                 fixedAnalysisModel.allCounter += stat-MULTIPLE_ADD;
//               }break;
//             }
//
//           }
//         }
//
//     return file.writeAsString(json.encode(list.toString()));
//   }
//
//   static Future<List<FixedAnalysisModel>> readFixedProgress() async {
//     List<FixedAnalysisModel> list = [];
//     final file = await _localFile;
//
//     try {
//       // 파일 읽기
//       list = json.decode(await file.readAsString()).cast<FixedAnalysisModel>().toList();
//     } catch(e){
//       logger.d("noting in fixed list");
//     }
//     return list;
//   }
//
//   static Future<File> deleteAnalysisFixed(String todo) async{
//     List<FixedAnalysisModel> list = [];
//     final file = await _localFile;
//
//     try {
//       // 파일 읽기
//       list = json.decode(await file.readAsString()).cast<FixedAnalysisModel>().toList();
//       for(FixedAnalysisModel fixedAnalysisModel in list) {
//         if (fixedAnalysisModel.todo == todo) {
//           list.remove(fixedAnalysisModel);
//           break;
//         }
//       }
//     } catch(e){
//       logger.d("이니셜 에러");
//     }
//
//     return file.writeAsString(json.encode(list.toString()));
//   }
// }