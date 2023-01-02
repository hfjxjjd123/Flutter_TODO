import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:secare/data/profile_model.dart';
import 'dart:convert';

class ProfileEditService{

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> get _localFileProfile async {
    final path = await _localPath;
    return File('$path/profile.txt');
  }

  static Future<ProfileModel> readProfile() async {
    try {
      final file = await _localFileProfile;

      // 파일 읽기
      String profileString = await file.readAsString();
      ProfileModel profileModel = ProfileModel.fromStringData(profileString);
      return profileModel;
    } catch(e){
      return ProfileModel(name: 'OOO', job: 'OOO');
    }

  }

  static Future<File> writeProfile(String name, String job) async {
    final file = await _localFileProfile;

    // 파일 쓰기
    return file.writeAsString(json.encode(ProfileModel(name: name, job: job).toJson()));
  }
}


