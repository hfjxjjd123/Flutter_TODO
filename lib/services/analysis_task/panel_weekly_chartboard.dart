import 'package:flutter/material.dart';
import 'package:secare/const/colors.dart';
import 'package:secare/const/size.dart';

import 'widget_weekly_charts.dart';



class WeeklyChartBoard extends StatelessWidget {
  List<double> tmpIn = [0.6,0.7,0.44];

  @override
  Widget build(BuildContext context) {

    return Container(
      height: SIZE.height*0.35,
      color: offColor,
      child: Column(
        children: [
          Container(height: SIZE.height *0.03,),
          Text("weekly progress",style: Theme.of(context).textTheme.headline4?.copyWith(fontSize: 20),),
          Container(height: SIZE.height *0.04,),
          WeeklyCharts(tmpIn),

        ],
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }
}
