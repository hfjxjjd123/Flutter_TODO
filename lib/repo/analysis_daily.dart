// import 'dart:convert';
// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:secare/repo/analysis_service_accumulate.dart';
// import 'package:secare/repo/analysis_service_fixed.dart';
// import 'package:secare/repo/dtask_service.dart';
// import 'package:secare/repo/profile_service.dart';
// import 'package:secare/test/test_screen.dart';
// import 'package:secare/widgets/datetime_widget.dart';
// import '../const/fetching_analysis_flag.dart';
// import '../const/mid.dart';
// import '../data/daily_analysis_model.dart';
// import '../data/task_model.dart';
// import 'analysis_accumulate.dart';
//
// class AnalysisDaily{
//
//   static Future<String> get _localPath async {
//     final directory = await getApplicationDocumentsDirectory();
//
//     return directory.path;
//   }
//
//   static Future<File> get _localFile async {
//     final path = await _localPath;
//
//     try{
//       return File('$path/analysis_daily/${DateView.getDate()}.txt');
//     } catch (e){
//       Directory('analysis_daily').create()
//           .then((Directory directory) => logger.d("creat directory path!!"+directory.path));
//       return File('$path/analysis_daily/${DateView.getDate()}.txt');
//     }
//
//   }
//
//
//   //when you first signUp
//   static Future initAnalysisDaily(DailyAnalysisModel dailyAnalysisModel) async{
//     final file = await _localFile;
//     // 파일 읽기
//     return file.writeAsString(json.encode(dailyAnalysisModel.toJson()));
//   }
//
//   static Future<File> updateAnalysisDaily(int stat) async{
//
//     final file = await _localFile;
//     String stringData;
//     DailyAnalysisModel dailyAnalysisModel;
//     logger.d("Stat: $stat");
//
//     try{
//       stringData = await file.readAsString();
//       dailyAnalysisModel = DailyAnalysisModel.fromStringData(stringData);
//     } catch(e){
//       await lazyDaysAdd();
//       stringData = '';
//       dailyAnalysisModel = DailyAnalysisModel(date: DateView.getDate(), allCounter: 0, doneCounter: 0);
//     }
//
//       switch(stat){
//         case ADD_NEW:{
//           dailyAnalysisModel.allCounter++;
//         } break;
//         case DELETE_DO:{
//           dailyAnalysisModel.allCounter--;
//         } break;
//         case DELETE_DONE:{
//           dailyAnalysisModel.doneCounter--;
//           dailyAnalysisModel.allCounter--;
//         } break;
//         case DONE_TO_DO:{
//           dailyAnalysisModel.doneCounter--;
//         } break;
//         case DO_TO_DONE:{
//           dailyAnalysisModel.doneCounter++;
//         } break;
//         case RENAME:break;
//         case READ:break;
//         default: break;
//       }
//
//       return file.writeAsString(json.encode(dailyAnalysisModel.toJson()));
//     }
//
//
//   static Future<double> readDailyProgress() async{
//
//     double progress;
//     try {
//       final file = await _localFile;
//
//       // 파일 읽기
//       DailyAnalysisModel dailyAnalysisModel = DailyAnalysisModel.fromStringData(await file.readAsString());
//       if(dailyAnalysisModel.allCounter != 0){
//         progress = dailyAnalysisModel.doneCounter/dailyAnalysisModel.allCounter;
//         logger.d("${dailyAnalysisModel.doneCounter}/${dailyAnalysisModel.allCounter}");
//         return progress;
//       } else{
//         return 0.0;
//       }
//     } catch (e) {
//       Directory('analysis_daily').create()
//           .then((Directory directory) => logger.d("creat directory path!!"+directory.path));
//       await initAnalysisDaily(DailyAnalysisModel(date: DateView.getDate(), allCounter: 0, doneCounter: 0));
//       return readDailyProgress();
//     }
//   }
//
//   static Future<List<DailyAnalysisModel>> readDaysProgress() async{
//     List<FileSystemEntity> file;
//
//     try{
//       file = Directory("$_localPath/analysis_daily/").listSync();
//     } catch(e){
//       Directory('analysis_daily').create()
//           .then((Directory directory) => logger.d(directory.path));
//       file = Directory("$_localPath/analysis_daily/").listSync();
//     }
//
//     List<String> files = [];
//     List<DailyAnalysisModel> progresses = [];
//
//     for(int i=0; i<file.length; i++){
//       if(file[i] is File) files.add(await (file[i] as File).readAsString());
//       DailyAnalysisModel dailyAnalysisModel = DailyAnalysisModel.fromStringData(files[i]);
//       progresses.add(dailyAnalysisModel);
//     }
//
//     return progresses;
//   }
//
//   static Future lazyDaysAdd() async{
//     logger.d("lazy update 실행됨");
//     int before = 1;
//     String date = DateView.getYesterDate(before);
//     logger.d("yesterday: $date");
//     String? last;
//     List<FileSystemEntity> file;
//
//     List<String> fixes = await ProfileService.readFixedTaskInProfile();
//     for(String fixedTask in fixes){
//       TaskModel taskModel = TaskModel(
//           todo: fixedTask,
//           isFixed: true
//       );
//
//       try{
//         file = Directory("$_localPath/analysis_daily/").listSync();
//       } catch(e){
//         Directory('analysis_daily').create()
//             .then((Directory directory) => logger.d(directory.path));
//         file = Directory("$_localPath/analysis_daily/").listSync();
//       }
//
//       if(file.isNotEmpty){
//         last = DailyAnalysisModel.fromStringData(file.last.toString()).date;
//         logger.d("last: $last");
//
//         while(last != "$date.txt"){
//           DailyAnalysisModel dailyAnalysisModel = DailyAnalysisModel(date: date,allCounter: fixes.length,doneCounter: 0);//
//           await initAnalysisDaily(dailyAnalysisModel);
//           await AnalysisServiceFixed.updateAnalysisFixed(taskModel.todo, MULTIPLE_ADD+fixes.length); //
//           await AnalysisAccumulate.updateAnalysisAccumulate(MULTIPLE_ADD+fixes.length);
//           before++;
//           date = DateView.getYesterDate(before);
//           logger.d("$date.txt" == last);
//         }
//       }
//
//       // 날짜별로 루프돌기
//
//     }
//   }
//
// }