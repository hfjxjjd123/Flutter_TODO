import 'package:beamer/beamer.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secare/const/size.dart';
import 'package:secare/data/daily_analysis_model.dart';
import 'package:secare/data/stuff_model.dart';
import 'package:secare/provider/onclick_notifier.dart';
import 'package:secare/const/colors.dart';
import 'package:secare/repo/analysis_service_daily.dart';
import 'package:secare/repo/dtask_service.dart';
import 'package:secare/repo/stuff_service.dart';
import 'package:secare/services/add_task/add_task_dialog.dart';
import 'package:secare/test/test_screen.dart';
import 'package:secare/widgets/datetime_widget.dart';
import 'package:secare/widgets/on_button.dart';

import '../data/task_model.dart';

enum _SelectedTab { calendar, home, analysis }

class DayScreen extends StatefulWidget {
  DayScreen({Key? key}) : super(key: key);

  @override
  State<DayScreen> createState() => _DayScreenState();
}

class _DayScreenState extends State<DayScreen> {

  @override
  Widget build(BuildContext context) {
    OnclickNotifier onclickNotifier = context.watch<OnclickNotifier>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: offColor,
        body: Column(
          children: [
            FutureBuilder<double>(
              future: AnalysisServiceDaily.readDailyProgress(),
              builder: (context, snapshot){
                return LinearProgressIndicator(
                  color: fadeColor,
                  backgroundColor: Colors.transparent,
                  value: (snapshot.hasData)?snapshot.data:0.0,
                  minHeight: 8,
                );
              }
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
              child: FutureBuilder<List<TaskModel>>(
                  future: DTaskService.readTasks(), //수정해
                  builder: (context, snapshot) {

                    if(snapshot.hasData){
                      List<Widget> fixedTasks = [];
                      List<Widget> tasks = [];
                      List<String> fTodo = [];
                      List<String> dTodo = [];
                      List<bool> fOn = [];
                      List<bool> dOn = [];
                      for(int i=0;i<snapshot.data!.length;i++){
                        if(snapshot.data![i].isFixed){
                          fixedTasks.add(OnButton(stuff: snapshot.data![i].todo));
                          fTodo.add(snapshot.data![i].todo);
                          fOn.add(snapshot.data![i].isDone);
                        } else{
                          tasks.add(OnButton(stuff: snapshot.data![i].todo));
                          dTodo.add(snapshot.data![i].todo);
                          dOn.add(snapshot.data![i].isDone);
                        }
                      }
                      List<Widget> allStuffs = [
                        ...fixedTasks,
                        columnSmallPadding(),
                        Divider(
                          color: Colors.white,
                          height: 1,
                          thickness: 1,
                          indent: SIZE.width*0.15,
                          endIndent: SIZE.width*0.15,
                        ),
                        columnSmallPadding(),
                        ...tasks,
                      ];

                      List<bool> onList = [
                        ...fOn,
                        false,
                        false,
                        false,
                        ...dOn,
                      ];

                      return ListView.builder(
                        itemCount: (allStuffs.length),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            child: Stack(
                                children: [
                                  Container(child: allStuffs[index], color:(onList[index])?onColor:offColor,),
                                  Positioned(
                                    child: Icon(
                                      Icons.check_circle,
                                      color: (onList[index])?Colors.white:Colors.transparent,
                                      size: buttonHeight*0.5,
                                    ),
                                    top: buttonHeight*0.25,
                                    left: buttonHeight*0.3,
                                  )
                                ]
                            ),
                            onTap: ()async{
                              if(index<fOn.length){
                                await DTaskService.updateTaskDone(fTodo[index]);

                                setState((){
                                  logger.d("done!!!");
                                });
                              }else if(index>fOn.length+2){
                                await DTaskService.updateTaskDone(dTodo[index-fTodo.length-3]);
                                setState((){
                                  logger.d("done!!!");
                                });
                              }
                            },
                          );
                        },
                      );
                    } else return Container(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                      color: offColor,
                    );

                  }
              ),
            ),
          ],
        ),
        floatingActionButton: Stack(
          children: [
            Align(
                alignment: Alignment(Alignment.bottomLeft.x+0.2 , Alignment.bottomLeft.y),
                child: FloatingActionButton(
                  heroTag: "toProfile",
                  onPressed: () {
                    Beamer.of(context).beamToNamed('/profile');
                  },
                  backgroundColor: Color.fromARGB(230, 255, 255, 255),
                  child: Icon(Icons.person, color: offColor,),
                )
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                heroTag: "toAddTask",
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,

                    builder: (BuildContext context){
                      return AddTaskDialog();
                    },
                  );
                },
                backgroundColor: Color.fromARGB(230, 255, 255, 255),
                child: Icon(Icons.add, color: offColor,),
              ),
            ),

          ],
        ),
      ),
    );
  }
}





