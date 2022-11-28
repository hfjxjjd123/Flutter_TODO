import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:secare/test/test_screen.dart';
import '../const/mid.dart';
import '../data/profile_model.dart';
import '../data/task_model.dart';

class ProfileService{

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/fixed.txt');
  }


  static Future<List<String>> readFixedTaskInProfile() async {
    final file = await _localFile;
    List<String> fixes = [];

    try{
      fixes = json.decode(await file.readAsString()).toList();
    } catch(e){
      logger.d("No fixes in profle");
    }

    return fixes;
  }

  static Future<File> addFixedTaskToProfile(String todo) async{
    final file = await _localFile;
    List<String> fixes = [];

    try{
      fixes = json.decode(await file.readAsString());
      fixes.add(todo);
      logger.d("thispoint!!"+fixes.toString());
    } catch(e){

      fixes.add(todo);
    }
    return file.writeAsString(fixes.toString());
  }

  static Future<File> deleteFixedTaskToProfile(TaskModelForProfile taskModelForProfile) async{

    List<String> list = [];
    final file = await _localFile;

    try {
      // 파일 읽기
      list = json.decode(await file.readAsString()).toList();
      for(String fixes in list) {
        if (fixes == taskModelForProfile.todo) {
          list.remove(fixes);
          break;
        }
      }
    } catch(e){
      logger.d("이니셜 에러");
    }

    return file.writeAsString(json.encode(list.toString()));
  }

  static Future deleteFile() async {
    try {
      final file = await _localFile;
      await file.delete();
    } catch (e) {
      return 0;
    }
  }
}