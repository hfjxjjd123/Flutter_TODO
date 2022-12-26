import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:secare/const/colors.dart';
import 'package:secare/repo/analysis_service_fixed.dart';
import 'package:secare/repo/dtask_service.dart';
import 'package:secare/repo/profile_service.dart';

import '../../const/fetching_analysis_flag.dart';
import '../../const/size.dart';
import '../../data/profile_model.dart';
import '../../data/task_model.dart';
import '../../repo/analysis_accumulate.dart';
import '../../repo/analysis_daily.dart';
import '../../repo/analysis_fixed.dart';
import '../../repo/analysis_service_accumulate.dart';
import '../../repo/analysis_service_daily.dart';
import '../../repo/profile_edit_service.dart';

class ProfileEditScreen extends StatefulWidget {
  ProfileEditScreen({Key? key}) : super(key: key);

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  TextEditingController _nameEditingController = TextEditingController();

  TextEditingController _jobEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: offColor,
          body: SizedBox(
            height: SIZE.height,
            child: Column(
              children: [
                Container(height: SIZE.height*0.02,),
                SizedBox(
                  width: SIZE.width*0.86,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: (){
                          context.beamBack();
                        },
                        highlightColor: Colors.white70,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                          child: Text("이전", style: Theme.of(context).textTheme.headline6,),
                        ),
                      ),
                      Expanded(child: Container()),
                      InkWell(
                        onTap: () async {
                          await ProfileEditService.writeProfile(_nameEditingController.text, _jobEditingController.text);
                          context.beamBack();
                        },
                        highlightColor: Colors.white70,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                          child: Text("수정", style: Theme.of(context).textTheme.headline6,),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(height: SIZE.height*0.05,),
                FutureBuilder<ProfileModel>(
                  future: ProfileEditService.readProfile(),
                    builder: (context, snapshot){
                    if(snapshot.hasData){
                      _nameEditingController.text = snapshot.data!.name;
                      _jobEditingController.text = snapshot.data!.job;
                      return Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("이름", style: Theme.of(context).textTheme.headline6!,),
                              SizedBox(
                                width: SIZE.width*0.7,
                                child: TextFormField(
                                  controller: _nameEditingController,
                                  maxLength: 4,
                                  cursorColor: Colors.white,
                                  autofocus: true,
                                  style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 18),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.all(1),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white, width: 2),

                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white, width: 2)
                                    ),
                                    hintText: "이름",
                                    hintStyle: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 18, color: Colors.white70),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(height: SIZE.height*0.02,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("직업", style: Theme.of(context).textTheme.headline6!,),
                              SizedBox(

                                width: SIZE.width*0.7,
                                child: TextFormField(
                                  controller: _jobEditingController,
                                  maxLength: 9,
                                  cursorColor: Colors.white,
                                  autofocus: true,
                                  style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 18),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.all(1),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white, width: 2),

                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white, width: 2)
                                    ),
                                    hintText: "직업",
                                    hintStyle: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 18, color: Colors.white70),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                      return Container();
                    }
                ),
                Container(height: SIZE.height*0.08,),
                Text("고정업무관리", style: Theme.of(context).textTheme.headline3,),
                Container(height: SIZE.height*0.025,),
                Expanded(
                  // List<int> items = List<int>.generate(100, (int index) => index);
                  child: FutureBuilder<List<TaskModel>>(
                    future: DTaskService.readTasks(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        List<String> fTodo = [];
                        List<bool> fOn = [];

                        for (int i = 0; i < snapshot.data!.length; i++) {
                          if (snapshot.data![i].isFixed) {
                            fTodo.add(snapshot.data![i].todo);
                            fOn.add(snapshot.data![i].isDone);
                          }
                        }

                        return ListView.builder( //StatefulWidget으로 따로 뺀 후 거기서 관리. ValueKey가 뭔지 확인.
                          itemCount: fTodo.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Slidable(
                              endActionPane: ActionPane(
                                extentRatio: 0.3,
                                motion: ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context)async{
                                      await AnalysisServiceDaily.updateAnalysisDaily(DELETE_DO + ((fOn[index])?1:0));
                                      await AnalysisAccumulate.updateAnalysisAccumulate(DELETE_DO + ((fOn[index])?1:0));

                                      await AnalysisServiceFixed.deleteAnalysisFixed(fTodo[index]);
                                      await ProfileService.deleteFixedTaskToProfile(TaskModelForProfile(todo: fTodo[index]));

                                      await DTaskService.deleteTask(fTodo[index]);
                                      setState((){});
                                    },
                                    backgroundColor: Colors.red,
                                    icon: Icons.delete,
                                  ),
                                  SlidableAction(
                                    onPressed: (context){

                                    },
                                    backgroundColor: offColor,
                                    icon: Icons.edit,
                                  ),
                                ],

                              ),
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0),
                                  child: Row(

                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            fTodo[index],
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: "SongMyung",
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 15,
                                        width: SIZE.width*0.01,
                                        color: Colors.red,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                        return Container();
                    }
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}