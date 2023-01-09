import 'dart:convert';
import 'dart:io';

import 'package:secare/data/fixed_analysis_model.dart';
import 'package:secare/repo/analysis_fixed.dart';
import 'package:secare/repo/dtask_service.dart';
import 'package:secare/test/test_screen.dart';
import 'package:secare/widgets/datetime_widget.dart';
import '../const/fetching_analysis_flag.dart';
import '../const/home_directory.dart';
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

  static Future<File> localFileForLazy(String date) async {
    final path = await _localDirPath;
    return File('$path/$date.txt');
  }

  static Future<File> initAnalysisDaily(
      DailyAnalysisModel dailyAnalysisModel) async {
    //파일 경로
    final file = await _localFile;
    //파일 쓰기
    return file.writeAsString(json.encode(dailyAnalysisModel.toJson()));
  }

  static Future<File> lazyInitAnalysisDaily(
      DailyAnalysisModel dailyAnalysisModel, String date) async {

    final file;
      //파일 경로
      file = await localFileForLazy(date);
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
          {
            dailyAnalysisModel.allCounter += stat - MULTIPLE_ADD;
          }
          break;
      }

      await file.writeAsString(json.encode(dailyAnalysisModel.toJson()));
    } catch (e) {
      logger.d("LAZY UPDATE IS DONE");
      await lazyDaysAdd();

      DailyAnalysisModel dailyAnalysisModel = DailyAnalysisModel(
          date: DateView.getDate(), allCounter: 0, doneCounter: 0);
      await initAnalysisDaily(dailyAnalysisModel);
      await updateAnalysisDaily(stat);
    }
  }

  static Future<bool> checkDayChange() async {

    try {
      final path = await _localFile;
      File file = File(path.path);

      DailyAnalysisModel dailyAnalysisModel =
          DailyAnalysisModel.fromStringData(await file.readAsString());

      return false;

    } catch (e) {
      logger.d("clear day...");
      await DTaskService.clearDay();

      List<FixedAnalysisModel> fixes =
          await AnalysisFixed.readFixedProgress(); //여기서도 날짜바뀜 감지
      for (FixedAnalysisModel fixedModel in fixes) {
        //완전 동일한 key를 가진 fixed task 생성
        TaskModel taskModel = TaskModel(todo: fixedModel.todo, isFixed: true);
        taskModel.key = fixedModel.key;

        //이젠 다른 키에 접근하는 것이 아니므로 ADD_NEW로 실제 추가생성되진 않음
        await AnalysisFixed.updateAnalysisFixed(taskModel, ADD_NEW);
        await DTaskService.writeTask(taskModel);
      }
      await updateAnalysisDaily(MULTIPLE_ADD + fixes.length);
      await AnalysisAccumulate.updateAnalysisAccumulate(
          MULTIPLE_ADD + fixes.length);

      return true;
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

  static Future<bool> lazyDaysAdd() async {

    //실제로 필요한 상황일 때?
    bool isLazy = true;

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

      //sorting
      days = sorting(days, length);
      logger.d(days);

      if (length != 0) {
        List<FixedAnalysisModel> fixes =
            await AnalysisFixed.readFixedProgress(); //여기서도 날짜바뀜 감지

        last = days[length - 1];
        logger.d(last == DateView.getDate2());
        if(last != DateView.getDate2()){
          logger.d("last: $last");
          logger.d("date: $date");
          logger.d(last == date);
          while (last != date) {
            DailyAnalysisModel dailyAnalysisModel = DailyAnalysisModel(
                date: DateView.getYesterDate(before), allCounter: fixes.length, doneCounter: 0); //
            await lazyInitAnalysisDaily(dailyAnalysisModel, date);

            TaskModel taskModel;
            for (FixedAnalysisModel fixedTask in fixes) {
              taskModel = TaskModel(todo: fixedTask.todo, isFixed: true);
              taskModel.key = fixedTask.key;

              await AnalysisFixed.updateAnalysisFixed(
                  taskModel, MULTIPLE_ADD + fixes.length);
            }
            await AnalysisAccumulate.updateAnalysisAccumulate(
                MULTIPLE_ADD + fixes.length);
            before++;
            date = DateView.getYesterDate2(before);
            logger.d(date == last);
          }

          DailyAnalysisModel dailyAnalysisModel = DailyAnalysisModel(
              date: DateView.getDate(), allCounter: length, doneCounter: 0);
          await initAnalysisDaily(dailyAnalysisModel);

          return isLazy;
        }else{
          logger.d("false lazy upload -- ");
          return false;
        }

      }

    } catch (e) {
      logger.d("Serious err");
    }
    return false;
    //전체리스트업 부분.

    // 날짜별로 루프돌기
  }

  static List<String> sorting(List<String> list, int length) {
    List<int> listInt = [];

    for (String str in list) {
      listInt.add(int.parse(str));
    }

    for (int i = 1; i <= length - 1; i++) {
      int key = listInt[i];
      int j = i - 1;

      while (j >= 0 && listInt[j] > key) {
        listInt[j + 1] = listInt[j];
        j--;
      }
      listInt[j + 1] = key;
    }

    list.clear();

    for (int num in listInt) {
      list.add(num.toString());
    }

    return list;
  }
}
