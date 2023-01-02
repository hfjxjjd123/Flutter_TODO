import 'dart:io';
import '../test/test_screen.dart';

Future<String> cd(String wd, String name) async {
  var directory = await Directory('$wd/$name').create(recursive: true);
  logger.d(directory.path);

  return directory.path;
}