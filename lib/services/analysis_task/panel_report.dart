import 'dart:math';

import 'package:flutter/material.dart';
import 'package:secare/data/daily_analysis_model.dart';
import 'package:secare/test/test_screen.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../const/size.dart';
import '../../repo/analysis_service_daily.dart';
import 'panel_daily_chartboard.dart';
import 'panel_weekly_chartboard.dart';

List<double> tmpIn = List<double>.filled(35, 0);

class PanelReport extends StatelessWidget {
  const PanelReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<DailyAnalysisModel>>(
      future: AnalysisServiceDaily.readDaysProgress(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          int snapshotLength = snapshot.data!.length;

          tmpIn = List<double>.filled(35, 0);
          double progress = 0.0;
          DailyAnalysisModel model;


          int maxLength = (snapshotLength>35)? 35: snapshotLength;
          List<DailyAnalysisModel> list = snapshot.data!.sublist(snapshotLength - maxLength ,snapshotLength);

          for(int i=0; i<maxLength; i++){
            model = list[i];
            progress = (model.allCounter !=0 && model.doneCounter>=0)? model.doneCounter/model.allCounter: 0.0;
            tmpIn[35-maxLength+i] = progress;
          }

          return SlidingUpPanel(
            minHeight: SIZE.height * 0.06,
            maxHeight: SIZE.height * 1,
            panel: Column(
              children: [
                Container(height: SIZE.height * 0.1,), // space
                WeeklyChartBoard(),
                Container(
                  height: SIZE.height * 0.1,
                  child: Center(
                      child: Text("daily progress",
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline4
                            ?.copyWith(fontSize: 20, color: Colors.black),
                      )
                  ),
                ), // space
                DailyChartBoard(),
                Expanded(
                    child: Center(
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.star),
                        color: Colors.amber,
                        iconSize: SIZE.height * 0.05,
                      ),
                    )
                )
              ],
            ),
            collapsed: Icon(Icons.keyboard_arrow_up_rounded, size: 30,),
          );
        } else{
          return Container();
        }
      }
    );
  }
}

