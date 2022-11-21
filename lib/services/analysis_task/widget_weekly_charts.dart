import 'package:flutter/material.dart';
import 'package:secare/const/size.dart';
import 'widget_week_progressbar.dart';

class WeeklyCharts extends StatelessWidget {
  WeeklyCharts(this.weeksProgress);
  List<double> weeksProgress;

  @override
  Widget build(BuildContext context) {

    int weeks = weeksProgress.length;

    return Row(
        children: [
          WeekProgressBar(weeksProgress[0]),
          Container(width: SIZE.width * 0.06,height: SIZE.height*0.15,),
          WeekProgressBar(weeksProgress[1]),
          Container(width: SIZE.width * 0.06,height: SIZE.height*0.15),
          WeekProgressBar(weeksProgress[2]),
          Container(width: SIZE.width * 0.06,height: SIZE.height*0.15),
          WeekProgressBarNow(weeksProgress[3]),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
      );

  }
}
