import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secare/test/test_screen.dart';
import 'package:secare/widgets/datetime_widget.dart';
import '../const/fetching_analysis_flag.dart';
import '../const/mid.dart';
import '../data/daily_analysis_model.dart';

class AnalysisServiceDaily{

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



    if(!snapshot.exists){
      logger.d("이건 절대 시행되면 안돼");
      DailyAnalysisModel dailyAnalysisModel = DailyAnalysisModel(date: DateView.getDate());
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
    DocumentReference<Map<String,dynamic>> documentReference =  FirebaseFirestore.instance
        .collection(MID).doc("Analysis")
        .collection("Days").doc(DateView.getDate());

    DocumentSnapshot<Map<String, dynamic>> snapshot = await documentReference.get();

    if(!snapshot.exists){
      logger.d("그런거 없습니다");
      return 0.0;
    } else{
      DailyAnalysisModel dailyAnalysisModel = DailyAnalysisModel.fromSnapshot(snapshot);

      int done = dailyAnalysisModel.doneCounter;
      int all = dailyAnalysisModel.allCounter;
      double progress  = done.toDouble()/all.toDouble();

      return progress;
    }
  }
}