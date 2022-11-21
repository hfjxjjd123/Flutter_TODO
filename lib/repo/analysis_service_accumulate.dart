import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secare/test/test_screen.dart';
import '../const/fetching_analysis_flag.dart';
import '../const/mid.dart';
import '../data/accumulate_analysis_model.dart';

class AnalysisServiceAccumulate{

  //when you first signUp
  static Future initAnalysisAccumulate(AccumulateAnalysisModel accumulateAnalysisModel) async{
    DocumentReference<Map<String, dynamic>> analDocReference = FirebaseFirestore.instance
        .collection(MID).doc("Analysis")
        .collection("Accumulate").doc("accumulate");

    final DocumentSnapshot documentSnapshot = await analDocReference.get();

    if(!documentSnapshot.exists){
      await analDocReference.set(accumulateAnalysisModel.toJson()); //이미 만들어져 있을거임..
    }
  }

  static Future updateAnalysisAccumulate(int stat) async{

    DocumentReference<Map<String, dynamic>> analDocReference = FirebaseFirestore.instance
        .collection(MID).doc("Analysis")
        .collection("Accumulate").doc("accumulate");

    final DocumentSnapshot<Map<String, dynamic>> snapshot = await analDocReference.get();



    if(!snapshot.exists){
      AccumulateAnalysisModel accumulateAnalysisModel = AccumulateAnalysisModel();
      initAnalysisAccumulate(accumulateAnalysisModel);
      updateAnalysisAccumulate(stat);
    } else{
      AccumulateAnalysisModel accumulateAnalysisModel = AccumulateAnalysisModel.fromSnapshot(snapshot);

      switch(stat){
        case ADD_NEW:{
          accumulateAnalysisModel.allCounter++;
        } break;
        case DELETE_DO:{
          accumulateAnalysisModel.allCounter--;
        } break;
        case DELETE_DONE:{
          accumulateAnalysisModel.doneCounter--;
          accumulateAnalysisModel.allCounter--;
        } break;
        case DONE_TO_DO:{
          accumulateAnalysisModel.doneCounter--;
        }
          break;
        case DO_TO_DONE: {
          accumulateAnalysisModel.doneCounter++;
        }break;
        case RENAME:break;
        case READ:break;
        default:{
            accumulateAnalysisModel.allCounter += stat-MULTIPLE_ADD;
          }break;
      }

      await analDocReference.update(accumulateAnalysisModel.toJson());
    }
  }

  static Future<double> readAccumulateProgress() async{

    double progress;

    DocumentReference<Map<String,dynamic>> documentReference =  FirebaseFirestore.instance
        .collection(MID).doc("Analysis")
        .collection("Accumulate").doc("accumulate");

    DocumentSnapshot<Map<String, dynamic>> snapshot = await documentReference.get();

    if(!snapshot.exists){
      logger.d("error!");
      return 0.0;
    } else{
      AccumulateAnalysisModel accumulateAnalysisModel = AccumulateAnalysisModel.fromSnapshot(snapshot);

      int done = accumulateAnalysisModel.doneCounter;
      int all = accumulateAnalysisModel.allCounter;
      if(all != 0){
        progress  = done.toDouble()/all.toDouble();
      } else {
        progress = 0;
      }

      return progress;
    }
  }
}