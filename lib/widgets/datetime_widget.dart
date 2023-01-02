import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateView extends StatelessWidget {
  Widget build(context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        getToday(),
        style: TextStyle(fontSize: 40, color: Colors.white, fontFamily: "SongMyung"),
      ),
    );
  }

  String getToday() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('MM. dd');
    var strToday = formatter.format(now);
    return strToday;
  }

  static String getDate(){
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy. MM. dd');
    var strToday = formatter.format(now);
    return strToday;
  }
  static String getDate2(){
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyyMMdd');
    var strToday = formatter.format(now);
    return strToday;
  }

  static String getYesterDate(int n){
    DateTime yes = DateTime.now().subtract(Duration(days: n));
    DateFormat formatter = DateFormat('yyyy. MM. dd');
    var strYesterday = formatter.format(yes);
    return strYesterday;
  }

  static String getYesterDate2(int n){
    DateTime yes = DateTime.now().subtract(Duration(days: n));
    DateFormat formatter = DateFormat('yyyyMMdd');
    var strYesterday = formatter.format(yes);
    return strYesterday;
  }


  static int getWeekday(){
    DateTime now = DateTime.now();
    return now.weekday;
  }
}