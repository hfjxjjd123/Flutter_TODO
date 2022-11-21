import 'package:flutter/material.dart';
import 'package:secare/const/size.dart';
import 'package:secare/data/daily_analysis_model.dart';
import 'package:secare/repo/analysis_service_daily.dart';
import 'package:secare/test/test_screen.dart';
import './widget_daily_charts.dart';
import './widget_daily_progressbar.dart';
import 'panel_report.dart';

class DailyChartBoard extends StatelessWidget {
  const DailyChartBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

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
