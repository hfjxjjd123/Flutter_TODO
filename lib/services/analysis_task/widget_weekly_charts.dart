import 'package:flutter/material.dart';
import 'package:secare/const/size.dart';
import 'widget_week_progressbar.dart';

class WeeklyCharts extends StatelessWidget {
  WeeklyCharts(this.weeksProgress);
  List<double> weeksProgress;

  @override
  Widget build(BuildContext context) {

    int weeks = weeksProgress.length;
    if(weeks<4){
      for(int i = weeks; i<4; i++){
        weeksProgress.insert(0,0);
      }
    }
    return Row(
      children: [
        WeekProgressBar(weeksProgress[0]),
        Container(width: SIZE.width * 0.06,),
        WeekProgressBar(weeksProgress[1]),
        Container(width: SIZE.width * 0.06,),
        WeekProgressBar(weeksProgress[2]),
        Container(width: SIZE.width * 0.06,),
        WeekProgressBarNow(weeksProgress[3]),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
    );
  }
}
