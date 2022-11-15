import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../const/size.dart';
import 'panel_daily_chartboard.dart';
import 'panel_weekly_chartboard.dart';

class PanelReport extends StatelessWidget {
  const PanelReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SlidingUpPanel(
      minHeight: SIZE.height*0.06,
      maxHeight: SIZE.height*1,
      panel: Column(
        children: [
          Container(height: SIZE.height * 0.1,), // space
          WeeklyChartBoard(),
          Container(
            height: SIZE.height * 0.1,
            child: Center(
                child: Text("daily progress",
                  style: Theme.of(context).textTheme.headline4
                      ?.copyWith(fontSize: 20, color: Colors.black),
                )
            ),
          ), // space
          DailyChartBoard(),
          Expanded(
              child: Center(
                child: IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.star),
                  color: Colors.amber,
                  iconSize: SIZE.height*0.05,
                ),
              )
          )
        ],
      ),
      collapsed: Icon(Icons.keyboard_arrow_up_rounded, size: 30,),
    );
  }
}

