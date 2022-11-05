import 'package:flutter/material.dart';
import '../data/stuff_model.dart';
import '../repo/stuff_service.dart';
import '../const/colors.dart';
import '../const/size.dart';
import '../widgets/datetime_widget.dart';
import 'bloc.dart';

class TestButton extends StatefulWidget {
  TestButton({Key? key, required this.stuffModel}) : super(key: key);

  StuffModel stuffModel;

  @override
  State<TestButton> createState() => _TestButtonState();
}

class _TestButtonState extends State<TestButton> {
  get isOn => widget.stuffModel.isDone;

  Widget build(BuildContext context) {
  //버튼 객체의 사이즈를 조절하는 부
  return InkWell(
    child: Container(
      child: Text(
        widget.stuffModel.todo,
        style: TextStyle(
          color: Colors.white,
          fontSize: 21,
          fontFamily: "SongMyung"
        ),
      ),
      alignment: Alignment.center,
      height: buttonHeight,
      color: (isOn)?onColor:offColor,
  ),
    onTap:()async{
      widget.stuffModel.isDone = !isOn;
      //데이터베이스도 수정될 수 있게 추가
      await StuffService.updateStuff(widget.stuffModel);
      BLOC().sinkStuffList(StuffService.getAllStuffs(widget.stuffModel.day));
      setState((){});

    },
  );
}
}

//////////

class CreateStuffButton extends StatelessWidget {
  const CreateStuffButton({Key? key}) : super(key: key);

  Future attemptUploadStuffs(String stuff) async{
    String day = DateView.getDate();
    String todo = stuff; // 입력받아야함
    String stuffId = day+todo;

    StuffModel stuffModel = StuffModel(
      day:day, todo: todo, stuffId:stuffId,
    );

    await StuffService.uploadNewStuff(stuffModel);
  }

  @override
  Widget build(BuildContext context) {
    String controllerString = 'didi';
    return InkWell(
      child: Container(
        child: TextField(
            //안쪽 채우기
        ),
        alignment: Alignment.center,
        height: buttonHeight,
        color: onColor,
      ),
      onTap: ()async{
        await attemptUploadStuffs(controllerString); //수정
        //if 이미 존재하는 할일, 얼럴트 이미 존재하는 할 일 입니다.
        //if done
        //controller.clear()
      },
    );
  }
}