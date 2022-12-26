import 'package:flutter/material.dart';

class DailyProgressBar extends StatelessWidget {
  DailyProgressBar(this.progress);
  double progress;
  int progressLevel = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int progressLevel = (progress*100).floor()~/20; //0~5까지 가능

    return Container(
      width: size.width*0.06,
      height: size.width*0.06,
      margin: EdgeInsets.all(size.width*0.02),
      color: (progressLevel == 0)? Color.fromARGB(255, 217, 217, 217): Color.fromARGB(50*progressLevel, 4, 191, 157),
    );
  }
}
