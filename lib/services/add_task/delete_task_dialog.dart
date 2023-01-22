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

class DeleteTaskDialog extends StatefulWidget {
  final Function() notifyParent;
  final TaskModel taskModel;
  final bool isOn;

  const DeleteTaskDialog({Key? key, required this.notifyParent, required this.taskModel, required this.isOn})
      : super(key: key);

  @override
  State<DeleteTaskDialog> createState() => _DeleteTaskDialogState();
}

class _DeleteTaskDialogState extends State<DeleteTaskDialog> {

  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController(text: widget.taskModel.todo);

    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      content: Container(
        height: SIZE.height * 0.20,
        child: (_isDeleting)
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
              child: Column(
                children: [
                  Text("\'${widget.taskModel.todo}\'",
                    style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: SIZE.width*0.05),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text("를 정말로 삭제하시겠습니까?",style: Theme.of(context).textTheme.headline4!.copyWith(
                    fontSize: SIZE.width*0.045,
                  ),),
                ],
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
                        _isDeleting = true;
                        setState(() {});

                        await AnalysisDaily.updateAnalysisDaily(DELETE_DO + ((widget.isOn)?1:0));
                        await AnalysisAccumulate.updateAnalysisAccumulate(DELETE_DO + ((widget.isOn)?1:0));

                        await AnalysisFixed.deleteAnalysisFixed(widget.taskModel.key);

                        await DTaskService.deleteTask(widget.taskModel.key);

                        widget.notifyParent();
                        Navigator.pop(context);
                      }
                    },
                    highlightColor: Colors.white70,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, top: 10, bottom: 10),
                      child: Text(
                        "삭제",
                        style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.red),
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
