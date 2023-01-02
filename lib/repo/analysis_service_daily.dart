import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secare/repo/analysis_fixed.dart';
import 'package:secare/repo/analysis_service_fixed.dart';
import 'package:secare/repo/dtask_service.dart';
import 'package:secare/repo/profile_service.dart';
import 'package:secare/test/test_screen.dart';
import 'package:secare/widgets/datetime_widget.dart';
import '../const/fetching_analysis_flag.dart';
import '../const/mid.dart';
import '../data/daily_analysis_model.dart';
import '../data/task_model.dart';
import 'analysis_accumulate.dart';

class AnalysisServiceDaily{ //Firebase 이용하기로 했음 directory issue

  //when you first signUp
  static Future initAnalysisDaily(DailyAnalysisModel dailyAnalysisModel) async{
    DocumentReference<Map<String, dynamic>> analDocReference = FirebaseFirestore.instance
        .collection(MID).doc("Analysis")
        .collection("Days").doc(dailyAnalysisModel.date);

    final DocumentSnapshot documentSnapshot = await analDocReference.get();

    if(!documentSnapshot.exists){
      await analDocReference.set(dailyAnalysisModel.toJson());
    }
  }

  static Future updateAnalysisDaily(int stat) async{

    DocumentReference<Map<String, dynamic>> analDocReference = FirebaseFirestore.instance
        .collection(MID).doc("Analysis")
        .collection("Days").doc(DateView.getDate());

    final DocumentSnapshot<Map<String, dynamic>> snapshot = await analDocReference.get();



    if(!snapshot.exists){ //여기서 새로운 날짜가 업데이트가 되는데 ...
      await lazyDaysAdd();

      DailyAnalysisModel dailyAnalysisModel = DailyAnalysisModel(date: DateView.getDate(), allCounter: 0, doneCounter: 0);
      await initAnalysisDaily(dailyAnalysisModel);
      await updateAnalysisDaily(stat);

    } else{
      DailyAnalysisModel dailyAnalysisModel = DailyAnalysisModel.fromSnapshot(snapshot);

        switch(stat){
          case ADD_NEW:{
            dailyAnalysisModel.allCounter++;
          } break;
          case DELETE_DO:{
            dailyAnalysisModel.allCounter--;
          } break;
          case DELETE_DONE:{
            dailyAnalysisModel.doneCounter--;
            dailyAnalysisModel.allCounter--;
          } break;
          case DONE_TO_DO:{
            dailyAnalysisModel.doneCounter--;
          } break;
          case DO_TO_DONE:{
            dailyAnalysisModel.doneCounter++;
          } break;
          case RENAME:break;
          case READ:break;
          default: break;
        }

        await analDocReference.update(dailyAnalysisModel.toJson());
    }

  }

  static Future<double> readDailyProgress() async{

    double progress;

    DocumentReference<Map<String,dynamic>> documentReference =  FirebaseFirestore.instance
        .collection(MID).doc("Analysis")
        .collection("Days").doc(DateView.getDate());

    DocumentSnapshot<Map<String, dynamic>> snapshot = await documentReference.get();

    if(!snapshot.exists){

      await DTaskService.clearDay();

      List<String> fixes = await ProfileService.readFixedTaskInProfile(); //여기서도 날짜바뀜 감지
      for(String fixedTask in fixes){
        TaskModel taskModel = TaskModel(
          todo: fixedTask,
          isFixed: true
        );
        await AnalysisFixed.updateAnalysisFixed(taskModel, ADD_NEW);
        await DTaskService.writeTask(taskModel);
        await updateAnalysisDaily(ADD_NEW);
      }
      //나머지는 삭제하는 로직 수정요함

      return 0.0;
    } else{
      DailyAnalysisModel dailyAnalysisModel = DailyAnalysisModel.fromSnapshot(snapshot);

      int done = dailyAnalysisModel.doneCounter;
      int all = dailyAnalysisModel.allCounter;
      if(all != 0){
        progress  = done.toDouble()/all.toDouble();
      } else {
        progress = 0;
      }

      return progress;
    }
  }

  static Future<List<DailyAnalysisModel>> readDaysProgress() async{

    CollectionReference<Map<String,dynamic>> collectionReference =  FirebaseFirestore.instance
        .collection(MID).doc("Analysis")
        .collection('Days');
    QuerySnapshot<Map<String, dynamic>> snapshots = await collectionReference.get();

    List<DailyAnalysisModel> progresses = [];

    for(int i=0; i<snapshots.size ; i++){
      DailyAnalysisModel dailyAnalysisModel = DailyAnalysisModel.fromQuerySnapshot(snapshots.docs[i]);
      progresses.add(dailyAnalysisModel);
    }

    return progresses;
  }

  static Future lazyDaysAdd() async{
    logger.d("lazy update 실행됨");
    int before = 1;
    String date = DateView.getYesterDate(before);
    logger.d("yesterday: $date");
    String? last;

    List<String> fixes = await ProfileService.readFixedTaskInProfile(); //여기서도 날짜바뀜 감지
    for(String fixedTask in fixes){

      TaskModel taskModel = TaskModel(
          todo: fixedTask,
          isFixed: true
      );

      CollectionReference<Map<String,dynamic>> collectionReference =  FirebaseFirestore.instance
          .collection(MID).doc("Analysis")
          .collection('Days');
      QuerySnapshot<Map<String, dynamic>> snapshots = await collectionReference.get();

      if(snapshots.size != 0){
        last = DailyAnalysisModel.fromQuerySnapshot(snapshots.docs[snapshots.size-1]).date;
        logger.d("last: $last");
        while(last != date){
          DailyAnalysisModel dailyAnalysisModel = DailyAnalysisModel(date: date,allCounter: fixes.length,doneCounter: 0);//
          await initAnalysisDaily(dailyAnalysisModel);
          await AnalysisFixed.updateAnalysisFixed(taskModel, MULTIPLE_ADD+fixes.length); //
          await AnalysisAccumulate.updateAnalysisAccumulate(MULTIPLE_ADD+fixes.length);
          before++;
          date = DateView.getYesterDate(before);
          logger.d(date == last);
        }
      }

      // 날짜별로 루프돌기

    }
  }

}