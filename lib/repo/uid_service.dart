import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class UidService{
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> get _localFileMID async {
    final path = await _localPath;
    return File('$path/device.txt');
  }

  static Future<String> readDeviceInfo() async {
    try {
      final file = await _localFileMID;

      // 파일 읽기
      String uid = await file.readAsString();
      return uid;
    } catch (e) {
      return "not found";
    }
  }

  static Future<File> writeDeviceInfo(String uid) async {
    final file = await _localFileMID;

    // 파일 쓰기
    return file.writeAsString(uid);
  }

  static String createUID(){
    return const Uuid().v1();
  }
}


