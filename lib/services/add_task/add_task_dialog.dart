import 'package:flutter/material.dart';
import 'package:secare/const/colors.dart';
import 'package:secare/const/fetching_analysis_flag.dart';
import 'package:secare/const/size.dart';
import 'package:secare/repo/analysis_service_daily.dart';
import 'package:secare/repo/analysis_service_fixed.dart';
import 'package:secare/repo/profile_service.dart';
import 'package:secare/test/test_screen.dart';

import '../../data/task_model.dart';
import '../../repo/analysis_accumulate.dart';
import '../../repo/analysis_daily.dart';
import '../../repo/analysis_fixed.dart';
import '../../repo/analysis_service_accumulate.dart';
import '../../repo/dtask_service.dart';
import '../../test/save.dart';

class AddTaskDialog extends StatefulWidget {
  final Function() notifyParent;
  const AddTaskDialog({Key? key, required this.notifyParent}) : super(key: key);

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  bool isFixedTask = true;
  TextEditingController _textEditingController = TextEditingController();
  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      content: Container(
        height: SIZE.height*0.23,
        child: (_isUploading) ?Center(child: CircularProgressIndicator(color: Colors.white70,),)
            :Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: SIZE.height*0.012,
            ),
            SizedBox(
              width: SIZE.width*0.5,
              child: TextFormField(
                controller: _textEditingController,
                cursorColor: Colors.white,
                autofocus: true,
                style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 20),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(1),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),

                  ),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2)
                  ),
                  hintText: " 추가할 작업",
                  hintStyle: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 20, color: Colors.white70),
                ),
              ),
            ),
            columnSmallPadding(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    isFixedTask = true;
                    setState((){});
                  },
                  highlightColor: Colors.white70,
                  child: Container(
                    width: SIZE.width*0.25,
                    height: SIZE.height*0.05,
                    decoration: BoxDecoration(
                      color: (isFixedTask)?onColor:offColor,
                      borderRadius: BorderRadius.circular(5),
                    ),

                    child: Center(
                      child: Text("고정업무", style: Theme.of(context).textTheme.headline4,),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    isFixedTask = false;
                    setState((){});
                  },
                  highlightColor: Colors.white70,
                  child: Container(
                    width: SIZE.width*0.25,
                    height: SIZE.height*0.05,
                      decoration: BoxDecoration(
                        color: (isFixedTask)?offColor:onColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    child: Center(
                      child: Text("일일업무", style: Theme.of(context).textTheme.headline4,),
                    ),
                  ),
                ),
              ],
            ),
            columnSmallPadding(),
            SizedBox(
              width: SIZE.width*0.5,
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    highlightColor: Colors.white70,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                      child: Text("취소", style: Theme.of(context).textTheme.headline6,),
                    ),
                  ),
                  Expanded(child: Container()),
                  InkWell(
                    onTap: () async {
                      _isUploading = true;
                      setState((){});

                      TaskModel taskModel = TaskModel(
                        todo: _textEditingController.text,
                        isFixed: isFixedTask,
                      );

                      await DTaskService.writeTask(taskModel);
                      await AnalysisServiceDaily.updateAnalysisDaily(ADD_NEW);
                      await AnalysisAccumulate.updateAnalysisAccumulate(ADD_NEW);

                      if(isFixedTask){
                        await ProfileService.addFixedTaskToProfile(taskModel.todo);
                        await AnalysisServiceFixed.updateAnalysisFixed(taskModel.todo, ADD_NEW);
                      }
                      widget.notifyParent();
                      Navigator.pop(context);
                    },
                    highlightColor: Colors.white70,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      child: Text("확인", style: Theme.of(context).textTheme.headline6,),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: offColor,
    );
  }
}

