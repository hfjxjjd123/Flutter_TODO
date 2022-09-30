import 'package:flutter/material.dart';
import 'package:secare/data/stuff_model.dart';
import 'package:secare/test/test_screen.dart';
import '../const/colors.dart';
import 'bloc.dart';

class TestButton extends StatefulWidget {
  TestButton({Key? key, required this.stuffModel}) : super(key: key);

  StuffModel stuffModel;
  late bool isOn = stuffModel.isDone;

  @override
  State<TestButton> createState() => _TestButtonState();
}

class _TestButtonState extends State<TestButton> {
  get isOn => widget.isOn;

  Widget build(BuildContext context) {
  //버튼 객체의 사이즈를 조절하는 부분
  Size size = MediaQuery.of(context).size;
  double buttonHeight = size.height*0.1;

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
    onTap:(){
      widget.isOn = isOn;
      //데이터베이스도 수정될 수 있게 추가
      setState((){});
      BLOC.progressController.sink.add(isOn);
    },
  );
}
}