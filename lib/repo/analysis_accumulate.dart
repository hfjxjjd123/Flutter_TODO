import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:secare/test/test_screen.dart';
import '../const/fetching_analysis_flag.dart';
import '../const/mid.dart';
import '../data/accumulate_analysis_model.dart';

//done

class AnalysisAccumulate{

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/accumulate.txt');
  }

  static Future<double> readAnalysisAccumulate() async {
    double progress;
    try {
      final file = await _localFile;

      // 파일 읽기
      AccumulateAnalysisModel accumulateAnalysisModel = AccumulateAnalysisModel.fromStringData(await file.readAsString());
      if(accumulateAnalysisModel.allCounter != 0){
        progress = accumulateAnalysisModel.doneCounter/accumulateAnalysisModel.allCounter;
        logger.d("${accumulateAnalysisModel.doneCounter}/${accumulateAnalysisModel.allCounter}");
        return progress;
      } else{
        return 0.0;
      }
    } catch (e) {
      await initAnalysisAccumulate();
      return readAnalysisAccumulate();
    }
  }
  //when you first signUp
  static Future<File> initAnalysisAccumulate() async{
      final file = await _localFile;
      // 파일 읽기
      return file.writeAsString(json.encode(AccumulateAnalysisModel().toJson()));
  }

  static Future<File> updateAnalysisAccumulate(int stat) async{
      final file = await _localFile;
      String stringData;
      AccumulateAnalysisModel accumulateAnalysisModel;
      logger.d("Stat: $stat");
      try{
        stringData = await file.readAsString();
        accumulateAnalysisModel = AccumulateAnalysisModel.fromStringData(stringData);
      } catch(e){
        stringData = '';
        accumulateAnalysisModel = AccumulateAnalysisModel();
      }

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

        return file.writeAsString(json.encode(accumulateAnalysisModel.toJson()));

  }
}