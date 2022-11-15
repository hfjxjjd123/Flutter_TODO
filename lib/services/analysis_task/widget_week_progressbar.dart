import 'package:flutter/material.dart';
import 'package:secare/const/colors.dart';
import 'package:secare/const/size.dart';

class WeekProgressBar extends StatelessWidget {
  WeekProgressBar(this.progress);
  double progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: SIZE.width*0.12,
          height: (progress == 0)?SIZE.height*0.005:SIZE.height*0.15*progress,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            color: (progress == 0)? fadeColor:onColor,
          ),
        ),
        Text("",style: TextStyle(color: Colors.white, fontSize: 12),)
      ],
    );
  }
}

class WeekProgressBarNow extends StatelessWidget {
  WeekProgressBarNow(this.progress);
  double progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: SIZE.width*0.12,
          height: (progress == 0)?SIZE.height*0.005:SIZE.height*0.15*progress,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: (progress == 0)? Colors.green:onColor,
          ),
        ),
        Text("this week",style: TextStyle(color: Colors.white, fontSize: 12),)
      ],
    );
  }
}
