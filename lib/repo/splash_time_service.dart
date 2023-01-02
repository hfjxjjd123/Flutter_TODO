class SplashTimeService{
  static Future<String> delay() async{
    await Future.delayed(Duration(milliseconds: 500));
    return "done";
  }
}