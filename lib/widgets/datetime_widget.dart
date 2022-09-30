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
}