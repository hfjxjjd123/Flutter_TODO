import 'package:flutter/material.dart';
import 'widget_daily_progressbar.dart';

class DailyCharts extends StatelessWidget {

  DailyCharts(this.datesProgress);
  List<double> datesProgress;

  @override
  Widget build(BuildContext context) {

    int days = datesProgress.length;
    if(days<35){
      for(int i = days; i<35; i++){
        datesProgress.insert(0,0);
      }
    }

    return Column(
      children: [
        Row(
          children: [
            DailyProgressBar(datesProgress[0]),
            DailyProgressBar(datesProgress[1]),
            DailyProgressBar(datesProgress[2]),
            DailyProgressBar(datesProgress[3]),
            DailyProgressBar(datesProgress[4]),
            DailyProgressBar(datesProgress[5]),
            DailyProgressBar(datesProgress[6]),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        Row(
          children: [
            DailyProgressBar(datesProgress[7]),
            DailyProgressBar(datesProgress[8]),
            DailyProgressBar(datesProgress[9]),
            DailyProgressBar(datesProgress[10]),
            DailyProgressBar(datesProgress[11]),
            DailyProgressBar(datesProgress[12]),
            DailyProgressBar(datesProgress[13]),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        Row(
          children: [
            DailyProgressBar(datesProgress[14]),
            DailyProgressBar(datesProgress[15]),
            DailyProgressBar(datesProgress[16]),
            DailyProgressBar(datesProgress[17]),
            DailyProgressBar(datesProgress[18]),
            DailyProgressBar(datesProgress[19]),
            DailyProgressBar(datesProgress[20]),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        Row(
          children: [
            DailyProgressBar(datesProgress[21]),
            DailyProgressBar(datesProgress[22]),
            DailyProgressBar(datesProgress[23]),
            DailyProgressBar(datesProgress[24]),
            DailyProgressBar(datesProgress[25]),
            DailyProgressBar(datesProgress[26]),
            DailyProgressBar(datesProgress[27]),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        Row(
          children: [
            DailyProgressBar(datesProgress[28]),
            DailyProgressBar(datesProgress[29]),
            DailyProgressBar(datesProgress[30]),
            DailyProgressBar(datesProgress[31]),
            DailyProgressBar(datesProgress[32]),
            DailyProgressBar(datesProgress[33]),
            DailyProgressBar(datesProgress[34]),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}
