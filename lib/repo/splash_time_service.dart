class SplashTimeService{
  static Future<String> delay() async{
    await Future.delayed(Duration(milliseconds: 780));
    return "done";
  }
}