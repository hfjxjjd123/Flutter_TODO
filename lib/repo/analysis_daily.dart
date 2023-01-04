import 'dart:convert';
import 'dart:io';


import 'package:secare/data/fixed_analysis_model.dart';
import 'package:secare/repo/analysis_fixed.dart';
import 'package:secare/repo/dtask_service.dart';
import 'package:secare/repo/profile_service.dart';
import 'package:secare/test/test_screen.dart';
import 'package:secare/widgets/datetime_widget.dart';
import '../const/fetching_analysis_flag.dart';
import '../const/home_directory.dart';
import '../const/mid.dart';
import '../data/daily_analysis_model.dart';
import '../data/task_model.dart';
import 'analysis_accumulate.dart';
import 'create_directory.dart';

class AnalysisDaily {
  //Firebase 이용하기로 했음 directory issue

  static Future<String> get _localDirPath async {
    String path = HOME;

    path = await cd(path, "adays");

    return path;
  }

  static Future<File> get _localFile async {
    final path = await _localDirPath;
    return File('$path/${DateView.getDate2()}.txt');
  }

  static Future<File> initAnalysisDaily(
      DailyAnalysisModel dailyAnalysisModel) async {
    //파일 경로
    final file = await _localFile;
    //파일 쓰기
    return file.writeAsString(json.encode(dailyAnalysisModel.toJson()));
  }

  static Future updateAnalysisDaily(int stat) async {
    try {
      final path = await _localFile;
      File file = File(path.path);

      // 데이터모델 읽어옴
      DailyAnalysisModel dailyAnalysisModel =
          DailyAnalysisModel.fromStringData(await file.readAsString());

      switch (stat) {
        case ADD_NEW:
          {
            dailyAnalysisModel.allCounter++;
          }
          break;
        case DELETE_DO:
          {
            dailyAnalysisModel.allCounter--;
          }
          break;
        case DELETE_DONE:
          {
            dailyAnalysisModel.doneCounter--;
            dailyAnalysisModel.allCounter--;
          }
          break;
        case DONE_TO_DO:
          {
            dailyAnalysisModel.doneCounter--;
          }
          break;
        case DO_TO_DONE:
          {
            dailyAnalysisModel.doneCounter++;
          }
          break;
        case RENAME:
          break;
        case READ:
          break;
        default:
          break;
      }

      await file.writeAsString(json.encode(dailyAnalysisModel.toJson()));
    } catch (e) {
      await lazyDaysAdd();
      logger.d("next?");

      DailyAnalysisModel dailyAnalysisModel = DailyAnalysisModel(
          date: DateView.getDate(), allCounter: 0, doneCounter: 0);
      await initAnalysisDaily(dailyAnalysisModel);
      await updateAnalysisDaily(stat);
    }
  }

  static Future<double> readDailyProgress() async {
    double progress;

    try {
      final path = await _localFile;
      File file = File(path.path);

      DailyAnalysisModel dailyAnalysisModel =
          DailyAnalysisModel.fromStringData(await file.readAsString());

      int done = dailyAnalysisModel.doneCounter;
      int all = dailyAnalysisModel.allCounter;
      if (all != 0) {
        progress = done.toDouble() / all.toDouble();
      } else {
        progress = 0;
      }

      return progress;
    } catch (e) {
      logger.d("errrrr");
      await DTaskService.clearDay();

      List<String> fixes =
          await ProfileService.readFixedTaskInProfile(); //여기서도 날짜바뀜 감지
      for (String fixedTask in fixes) {
        TaskModel taskModel = TaskModel(todo: fixedTask, isFixed: true);
        await AnalysisFixed.updateAnalysisFixed(taskModel, ADD_NEW);
        await DTaskService.writeTask(taskModel);
        await updateAnalysisDaily(ADD_NEW);
      }
      return 0.0;
    }
  }

  static Future<List<DailyAnalysisModel>> readDaysProgress() async {
    List<DailyAnalysisModel> progresses = [];
    List files = [];
    DailyAnalysisModel dailyAnalysisModel;

    try {
      final path = await _localDirPath;
      files = Directory('$path/').listSync();

      for (int i = 0; i < files.length; i++) {
        dailyAnalysisModel =
            DailyAnalysisModel.fromStringData(await files[i].readAsString());
        progresses.add(dailyAnalysisModel);
      }
    } catch (e) {
      logger.d("errrrorrr");
    }

    return progresses;
  }

  static Future lazyDaysAdd() async {
    logger.d("lazy update 실행됨");
    int before = 1;
    String date = DateView.getYesterDate2(before);
    String? last;

    List files = [];
    List<String> days = [];
    int length;
    FixedAnalysisModel fixedAnalysisModel;
    try {
      String path = await _localDirPath;
      files = Directory('$path/').listSync();

      length = files.length;

      for (int i = 0; i < length; i++) {
        days.add(files[i]
            .toString()
            .replaceFirst("$path/", "")
            .replaceAll(".txt", "")
            .replaceFirst("File: ", "")
            .replaceAll("\'", ""));
      }

      print(days);
      //sorting print

      if (length != 0) {
        List<String> fixes =
            await ProfileService.readFixedTaskInProfile(); //여기서도 날짜바뀜 감지

        last = days[length - 2];
        logger.d("last: $last");
        logger.d("date: $date");
        logger.d(last == date);
        while (last != date) {
          DailyAnalysisModel dailyAnalysisModel = DailyAnalysisModel(
              date: date, allCounter: fixes.length, doneCounter: 0); //
          await initAnalysisDaily(dailyAnalysisModel);
          for (String fixedTask in fixes) {
            await AnalysisFixed.updateAnalysisFixed(
                fixedTask, MULTIPLE_ADD + fixes.length);
          }
          await AnalysisAccumulate.updateAnalysisAccumulate(
              MULTIPLE_ADD + fixes.length);
          before++;
          date = DateView.getYesterDate2(before);
          logger.d(date == last);
        }
      }
      DailyAnalysisModel dailyAnalysisModel = DailyAnalysisModel(
          date: DateView.getDate(), allCounter: length, doneCounter: 0);
      await initAnalysisDaily(dailyAnalysisModel);
    } catch (e) {
      logger.d("Serious err");
    }

    //전체리스트업 부분.

    // 날짜별로 루프돌기
  }
}
