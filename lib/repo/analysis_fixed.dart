import 'dart:convert';
import 'dart:io';

import 'package:secare/test/test_screen.dart';
import '../const/fetching_analysis_flag.dart';
import '../const/home_directory.dart';
import '../data/fixed_analysis_model.dart';
import '../data/task_model.dart';
import 'create_directory.dart';

class AnalysisFixed {
  static Future<String> get _localDirPath async {
    String path = HOME;

    path = await cd(path, "afixes");

    return path;
  }

  static Future<File> createAnalysisFixed(TaskModel taskModel) async {
    final path = await _localDirPath;
    File file = File('$path/${taskModel.key}.txt');

    FixedAnalysisModel fixedAnalysisModel =
        FixedAnalysisModel(todo: taskModel.todo, key: taskModel.key);

    return file.writeAsString(json.encode(fixedAnalysisModel.toJson()));
  }

  static Future<File> updateAnalysisFixed(TaskModel taskModel, int stat) async {
    try {
      final path = await _localDirPath;
      File file = File('$path/${taskModel.key}.txt');

      // 데이터모델 읽어옴
      FixedAnalysisModel fixedAnalysisModel =
          FixedAnalysisModel.fromStringData(await file.readAsString());

      switch (stat) {
        case ADD_NEW:
          {
            fixedAnalysisModel.allCounter++;
          }
          break;
        case DELETE_DO:
          {
            fixedAnalysisModel.allCounter--;
          }
          break;
        case DELETE_DONE:
          {
            fixedAnalysisModel.doneCounter--;
            fixedAnalysisModel.allCounter--;
          }
          break;
        case DONE_TO_DO:
          {
            fixedAnalysisModel.doneCounter--;
          }
          break;
        case DO_TO_DONE:
          {
            fixedAnalysisModel.doneCounter++;
          }
          break;
        case RENAME:
          break;
        case READ:
          break;
        default:
          {
            fixedAnalysisModel.allCounter += stat - MULTIPLE_ADD;
          }
          break;
      }
      //데이터모델 쓰기
      return file.writeAsString(json.encode(fixedAnalysisModel.toJson()));

    } catch (e) {
      await createAnalysisFixed(taskModel);
      return updateAnalysisFixed(taskModel, stat);
    }
  }

  static Future<List<FixedAnalysisModel>> readFixedProgress() async {
    List<FixedAnalysisModel> fixes = [];
    List files = [];
    int length;
    FixedAnalysisModel fixedAnalysisModel;

    try {
      String path = await _localDirPath;
      files = Directory('$path/').listSync();

      length = files.length;

      for (int i = 0; i < length; i++) {
        fixedAnalysisModel =
            FixedAnalysisModel.fromStringData(await files[i].readAsString());
        fixes.add(fixedAnalysisModel);
      }
    }catch (e){
      logger.d("Serious err");
    }

    return fixes;
  }

  //challenge: String todo -> cannot find dir, what if Model? then cannot use this func
  static Future<int> deleteAnalysisFixed(String key) async {

    try{
      final path = await _localDirPath;
      File file = File('$path/$key.txt');

      await file.delete();
      return 0;
    }
    catch(e){
      logger.d("this would not been done");
      return -1;
    }
  }
}
