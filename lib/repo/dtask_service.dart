import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secare/const/home_directory.dart';
import 'package:secare/repo/analysis_daily.dart';
import 'package:secare/repo/analysis_fixed.dart';
import 'package:secare/repo/analysis_service_daily.dart';
import 'package:secare/repo/create_directory.dart';
import 'package:secare/test/test_screen.dart';
import '../const/mid.dart';
import '../data/task_model.dart';
import 'analysis_accumulate.dart';

class DTaskService{

  static Future<String> get _localDirPath async {
    String path = HOME;

    path = await cd(path, "dtasks");

    return path;
  }

  //쓰기
  static Future<File> writeTask(TaskModel taskModel) async{

    final path = await _localDirPath;
    File file = File('$path/${taskModel.key}.txt');

    return file.writeAsString(json.encode(taskModel.toJson()));

  }

  static Future<File> updateTaskDone(TaskModel taskModel) async{

    final path = await _localDirPath;
    File file = File('$path/${taskModel.key}.txt');

      taskModel.isDone = !taskModel.isDone;
      int stat = (taskModel.isDone)?4:3;

      await AnalysisDaily.updateAnalysisDaily(stat);
      await AnalysisAccumulate.updateAnalysisAccumulate(stat);

      if(taskModel.isFixed == true){
        await AnalysisFixed.updateAnalysisFixed(taskModel, stat);
      }

    return file.writeAsString(json.encode(taskModel.toJson()));

  }

  //중복체크 수정요망

//수정과 생성을 나누면?//수정은 바뀐 onCOunt값을?

  static Future<List<TaskModel>> readTasks() async{

    List files = [];
    List<TaskModel> tasks = [];
    int length;
    TaskModel taskModel;

    try {
      String path = await _localDirPath;
      files = Directory('$path/').listSync();
      length = files.length;

      for (int i = 0; i < length; i++) {
        taskModel =
            TaskModel.fromStringData(await files[i].readAsString());
        tasks.add(taskModel);
      }
    }catch (e){
      logger.d("NO such dir: dtask");
    }

    return tasks;
  }

  static Future<int> deleteTask(String key) async{

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
  } // test this code in home

  static Future<void> clearDay() async{
    try{
      final path = await _localDirPath;
      final dir = Directory(path);
      dir.deleteSync(recursive: true);
    }
    catch(e){
      logger.d("this would not been done");
    }
  }


}