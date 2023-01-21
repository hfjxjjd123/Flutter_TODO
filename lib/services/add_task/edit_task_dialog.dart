import 'package:flutter/material.dart';
import 'package:secare/const/colors.dart';
import 'package:secare/const/fetching_analysis_flag.dart';
import 'package:secare/const/size.dart';
import 'package:secare/repo/analysis_daily.dart';
import 'package:secare/repo/analysis_fixed.dart';
import 'package:secare/test/test_screen.dart';

import '../../data/task_model.dart';
import '../../repo/analysis_accumulate.dart';
import '../../repo/dtask_service.dart';

class EditTaskDialog extends StatefulWidget {
  final Function() notifyParent;
  final TaskModel taskModel;

  const EditTaskDialog({Key? key, required this.notifyParent, required this.taskModel})
      : super(key: key);

  @override
  State<EditTaskDialog> createState() => _EditTaskDialogState();
}

class _EditTaskDialogState extends State<EditTaskDialog> {

  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController(text: widget.taskModel.todo);

    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      content: Container(
        height: SIZE.height * 0.23,
        child: (_isUploading)
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.white70,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: SIZE.height * 0.012,
                  ),
                  SizedBox(
                    width: SIZE.width * 0.5,
                    child: TextFormField(
                      controller: textEditingController,
                      cursorColor: Colors.white,
                      autofocus: true,
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontSize: 20),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(1),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2)),
                        hintText: " 변경할 작업",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(fontSize: 20, color: Colors.white70),
                      ),
                    ),
                  ),
                  columnSmallPadding(),
                  SizedBox(
                    width: SIZE.width * 0.5,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          highlightColor: Colors.white70,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 10, top: 10, bottom: 10),
                            child: Text(
                              "취소",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                        ),
                        Expanded(child: Container()),
                        InkWell(
                          onTap: () async {
                            if (textEditingController.text.isNotEmpty) {
                              _isUploading = true;
                              setState(() {});

                              await DTaskService.updateTaskTodo(widget.taskModel, textEditingController.text);
                              await AnalysisFixed.updateTaskTodo(widget.taskModel, textEditingController.text);

                              widget.notifyParent();
                              Navigator.pop(context);
                            }
                          },
                          highlightColor: Colors.white70,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, top: 10, bottom: 10),
                            child: Text(
                              "확인",
                              style: Theme.of(context).textTheme.headline6,
                            ),
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
