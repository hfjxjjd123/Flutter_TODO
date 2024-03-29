import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:secare/const/colors.dart';
import 'package:secare/const/fetching_analysis_flag.dart';
import 'package:secare/const/size.dart';
import 'package:secare/repo/analysis_daily.dart';
import 'package:secare/repo/analysis_fixed.dart';
import 'package:secare/test/test_screen.dart';

import '../../data/task_model.dart';
import '../../repo/analysis_accumulate.dart';
import '../../repo/dtask_service.dart';

class AddTaskDialog extends StatefulWidget {
  final Function() notifyParent;
  const AddTaskDialog({Key? key, required this.notifyParent}) : super(key: key);

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  bool isFixedTask = false;
  TextEditingController _textEditingController = TextEditingController();
  bool _isUploading = false;
  bool _isAlready = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      content: Container(
        height: SIZE.height*0.25,
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
                inputFormatters: [
                  FilteringTextInputFormatter(RegExp(r"^\s$"),
                      allow: false,
                      replacementString: _textEditingController.text)
                ],
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
                      child: Text("매일 할 일", style: Theme.of(context).textTheme.headline4,),
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
                      child: Text("오늘 할 일", style: Theme.of(context).textTheme.headline4,),
                    ),
                  ),
                ),
              ],
            ),
            Container(height: SIZE.height*0.01,),
            (_isAlready)?SizedBox(
              height: SIZE.height*0.02,
              width: SIZE.width*0.5,
              child: Center(
                child: Text(
                    "* 이미 존재하는 매일 할 일 입니다.",
                  style: Theme.of(context)
                      .textTheme.headline6!.copyWith(color: Colors.redAccent),
                ),
              ),
            ):Container(),
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
                      if(_textEditingController.text.isNotEmpty){
                        List<String> ftasks;
                        String todoAdd;
                        ftasks = await AnalysisFixed.readFTasksTodo();
                        todoAdd = RegExp(r"^\S+((\s*)(\S+))*")
                            .firstMatch(_textEditingController.text)![0].toString();

                        if(isFixedTask && ftasks.contains(todoAdd)){
                          _isAlready = true;
                          _textEditingController.text = todoAdd;
                          setState(() {});
                        }else{
                          _isUploading = true;
                          setState((){});

                          TaskModel taskModel = TaskModel(
                            todo: todoAdd,
                            isFixed: isFixedTask,
                          );



                          await DTaskService.writeTask(taskModel);
                          await AnalysisDaily.updateAnalysisDaily(ADD_NEW);
                          await AnalysisAccumulate.updateAnalysisAccumulate(ADD_NEW);

                          if(isFixedTask){
                            await AnalysisFixed.updateAnalysisFixed(taskModel, ADD_NEW);
                          }
                          widget.notifyParent();
                          Navigator.pop(context);
                        }
                      }
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

