import 'package:flutter/material.dart';
import 'package:secare/const/size.dart';
import './widget_daily_charts.dart';
import './widget_daily_progressbar.dart';

class DailyChartBoard extends StatelessWidget {
  const DailyChartBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<double> tmpIn = [0.67,0.8,0.6,0.55,0.3,0.4,0.3,0.1,1];

    return Stack(
      children:[
        Container(
          height: SIZE.height*0.35,
          color: Color.fromARGB(255, 227, 229, 231),
          child: DailyCharts(tmpIn),
        ),
        Positioned(
            child: Text("Today", style: TextStyle(fontSize: 10),),
          left: SIZE.width*0.755,
          top: SIZE. height*0.29,
        )
      ], 
    );
  }
}
