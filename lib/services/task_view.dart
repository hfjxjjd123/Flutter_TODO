import 'package:flutter/material.dart';
import 'package:secare/data/task_model.dart';

import '../const/colors.dart';
import '../const/size.dart';
import '../repo/dtask_service.dart';

class TaskView extends StatefulWidget {
  TaskView({
    Key? key,
    required this.allStuffs,
    required this.onList,
    required this.fixedTasks,
    required this.tasks,
    required this.fTodo,
    required this.dTodo,
    required this.fOn,
    required this.dOn,

  }) : super(key: key);

  List<Widget> allStuffs;
  List<bool> onList;
  List<Widget> fixedTasks;
  List<Widget> tasks;
  List<TaskModel> fTodo;
  List<TaskModel> dTodo;
  List<bool> fOn;
  List<bool> dOn;


  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
              });
              await DTaskService.updateTaskDone(widget.fTodo[index]);
            }else if(index>widget.fOn.length+2){
              setState((){
                widget.onList[index] = !widget.onList[index];
              });
              await DTaskService.updateTaskDone(widget.dTodo[index-widget.fTodo.length-3]);
            }
          },
        );
      },
    );
  }
}
