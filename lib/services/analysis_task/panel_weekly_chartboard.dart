import 'package:flutter/material.dart';
import 'package:secare/const/colors.dart';
import 'package:secare/const/size.dart';
import 'package:secare/services/analysis_task/panel_report.dart';
import 'package:secare/test/test_screen.dart';

import '../../widgets/datetime_widget.dart';
import 'widget_weekly_charts.dart';



class WeeklyChartBoard extends StatelessWidget {
  List<double> tmpInWeekly = List<double>.filled(4, 0);

  @override
  Widget build(BuildContext context) {
    int weekday = DateView.getWeekday();


    double result = 0;

    for(int i=0; i<weekday; i++){
      result += tmpIn[35-weekday+i];
      tmpInWeekly[3] = result/weekday;
    } //이번주 로직구현

    for(int i=0; i<3; i++){
      result = 0;
      for(int j=0; j<7; j++){
        result += tmpIn[14-weekday+7*i+j];
      }
      tmpInWeekly[i] = result/7;
    }

    return Container(
      height: SIZE.height*0.35,
      color: offColor,
      child: Column(
        children: [
          Container(height: SIZE.height *0.03,),
          Text("weekly progress",style: Theme.of(context).textTheme.headline4?.copyWith(fontSize: 20),),
          Container(height: SIZE.height *0.04,),
          WeeklyCharts(tmpInWeekly),

        ],
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }
}
