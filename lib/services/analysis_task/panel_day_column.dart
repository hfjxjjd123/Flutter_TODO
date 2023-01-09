import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:secare/data/task_model.dart';
import 'package:secare/services/onlyone.dart';
import 'package:secare/test/test_screen.dart';

import '../../const/colors.dart';
import '../../const/size.dart';
import '../../repo/dtask_service.dart';
import '../../widgets/datetime_widget.dart';

class DayColumn extends StatefulWidget {
  DayColumn({
    Key? key,
    required this.allStuffs,
    required this.onList,
    required this.fixedTasks,
    required this.tasks,
    required this.fTodo,
    required this.dTodo,
    required this.fOn,
    required this.dOn
  }) : super(key: key);

  List<Widget> allStuffs;
  List<bool> onList;
  List<Widget> fixedTasks;
  List<Widget> tasks;
  List<TaskModel> fTodo;
  List<TaskModel> dTodo;
  List<bool> fOn;
  List<bool> dOn;

  double progress =0.0;


  @override
  State<DayColumn> createState() => _DayColumnState();
}

class _DayColumnState extends State<DayColumn> {
  @override
  Widget build(BuildContext context) {

    int onCount = 0;
    int allCount = widget.fOn.length + widget.dOn.length;

    for(bool fixes in widget.fOn){
      if(fixes == true) onCount++;
    }
    for(bool daily in widget.dOn){
      if(daily == true) onCount++;
    }

    if(widget.onList.length > 3){
      if(onCount/allCount <= 1) {
        widget.progress = onCount/allCount;
      }else{
        widget.progress = 1.0;
      }
    }else {
      widget.progress = 0.0;
    }

    return Column(
      children: [
        FAProgressBar(
          borderRadius: BorderRadius.circular(2),
          currentValue: widget.progress,
          maxValue: 1,
          size: 10,
          backgroundColor: Colors.transparent,
          progressColor: fadeColor,
          animatedDuration: const Duration(milliseconds: 150),
          direction: Axis.horizontal,
        ),
        columnBigPadding(),
        DateView(),
        columnSmallPadding(),
        Divider(
          color: Colors.white,
          height: 1,
          thickness: 1,
          indent: SIZE.width*0.2,
          endIndent: SIZE.width*0.2,
        ),
        columnSmallPadding(),
        Expanded(
          child: OnlyOnePointerRecognizerWidget(
            child: ListView.builder(
              itemCount: (widget.allStuffs.length),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  child: Stack(
                      children: [
                        Container(color:(widget.onList[index])?onColor:offColor,child: widget.allStuffs[index],),
                        Positioned(
                          child: Icon(
                            Icons.check_circle,
                            color: (widget.onList[index])?Colors.white:Colors.transparent,
                            size: buttonHeight*0.5,
                          ),
                          top: buttonHeight*0.25,
                          left: buttonHeight*0.3,
                        )
                      ]
                  ),
                  onTap: ()async{
                    if(index<widget.fOn.length){
                      setState((){
                        widget.onList[index] = !widget.onList[index];
                        widget.fOn[index] = !widget.fOn[index];
                      });
                      await DTaskService.updateTaskDone(widget.fTodo[index]);

                    }else if(index>widget.fOn.length+2){
                      setState((){
                        widget.onList[index] = !widget.onList[index];
                        widget.dOn[index-widget.fOn.length-3] = !widget.dOn[index-widget.fOn.length-3];
                      });
                      await DTaskService.updateTaskDone(widget.dTodo[index-widget.fTodo.length-3]);
                    }
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
