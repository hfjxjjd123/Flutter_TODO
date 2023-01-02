import 'package:path_provider/path_provider.dart';

class GetHomedir{

  static Future<String> getHome() async{
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

}