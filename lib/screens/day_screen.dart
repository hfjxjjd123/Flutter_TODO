import 'dart:math';

import 'package:beamer/beamer.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:secare/const/fetching_analysis_flag.dart';
import 'package:secare/const/size.dart';
import 'package:secare/const/colors.dart';
import 'package:secare/repo/analysis_daily.dart';
import 'package:secare/repo/analysis_service_daily.dart';
import 'package:secare/repo/dtask_service.dart';
import 'package:secare/repo/profile_service.dart';
import 'package:secare/services/add_task/add_task_dialog.dart';
import 'package:secare/services/analysis_task/panel_day_column.dart';
import 'package:secare/test/test_screen.dart';
import 'package:secare/widgets/on_button.dart';

import '../data/task_model.dart';
import '../repo/analysis_accumulate.dart';
import '../repo/analysis_service_fixed.dart';

class DayScreen extends StatefulWidget {
  DayScreen({Key? key}) : super(key: key);

  @override
  State<DayScreen> createState() => DayScreenState();
}

class DayScreenState extends State<DayScreen> {

  late Future<List<TaskModel>> myFuture;

  @override
  void initState() {
    super.initState();
    myFuture = DTaskService.readTasks();
  }

  void refresh() {
    setState((){
      myFuture = DTaskService.readTasks();
    });
  }

  @override
  Widget build(BuildContext context) {

    // ProfileService.deleteFile();

    List<Widget> fixedTasks = [];
    List<Widget> tasks = [];
    List<TaskModel> fTodo = [];
    List<TaskModel> dTodo = [];
    List<bool> fOn = [];
    List<bool> dOn = [];

    AnalysisDaily.readDailyProgress();

    return SafeArea(
      child: Scaffold(
        backgroundColor: offColor,
        body: FutureBuilder<List<TaskModel>>(
          future: myFuture,
          builder: (context, snapshot) {

            if (snapshot.hasData) {
              fixedTasks.clear();
              tasks.clear();
              fTodo.clear();
              dTodo.clear();
              fOn.clear();
              dOn.clear();

              for (int i = 0; i < snapshot.data!.length; i++) {
                if (snapshot.data![i].isFixed) {
                  fTodo.add(snapshot.data![i]);
                  fOn.add(snapshot.data![i].isDone);
                  fixedTasks.add(
                    OnButton(stuff: snapshot.data![i].todo),
                  );
                } else {
                  dTodo.add(snapshot.data![i]);
                  dOn.add(snapshot.data![i].isDone);
                  tasks.add(
                    Slidable(
                      endActionPane: ActionPane(
                        extentRatio: 0.17,
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) async{
                              int index = dTodo.indexOf(snapshot.data![i]);
                              await AnalysisDaily.updateAnalysisDaily(DELETE_DO + ((dOn[index])?1:0));
                              await AnalysisAccumulate.updateAnalysisAccumulate(DELETE_DO + ((dOn[index])?1:0));

                              await DTaskService.deleteTask(dTodo[index].key);
                              refresh();
                            },
                            backgroundColor: Colors.red,
                            icon: Icons.delete,
                          ),
                        ],
                      ),
                      child: OnButton(stuff: snapshot.data![i].todo),
                    ),
                  );
                }
              }
              List<Widget> allStuffs = [
                ...fixedTasks,
                columnSmallPadding(),
                Divider(
                  color: Colors.white,
                  height: 1,
                  thickness: 1,
                  indent: SIZE.width * 0.15,
                  endIndent: SIZE.width * 0.15,
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

              return DayColumn(
                  allStuffs: allStuffs,
                  onList: onList,
                  fixedTasks: fixedTasks,
                  tasks: tasks,
                  fTodo: fTodo,
                  dTodo: dTodo,
                  fOn: fOn,
                  dOn: dOn
              );
            }
            else{
              return Container(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
                color: offColor,
              );
            }
          },
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
                      return AddTaskDialog(notifyParent: refresh);
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

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}



