import 'package:flutter/material.dart';
import 'package:secare/data/stuff_model.dart';
import 'package:secare/provider/onclick_notifier.dart';
import 'package:secare/repo/stuff_service.dart';
import 'package:secare/widgets/datetime_widget.dart';

import '../const/size.dart';


class OnButton extends StatefulWidget {
  OnButton({Key? key, required this.stuff}) : super(key: key);
  String stuff;

  @override
  State<OnButton> createState() => _OnButtonState();
}

class _OnButtonState extends State<OnButton> {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double buttonHeight = size.height*0.1;

    return Container(
      child: Text(
        widget.stuff,
        style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontFamily: "SongMyung"
        ),
      ),
      alignment: Alignment.center,
      height: buttonHeight,
      color: Colors.transparent,
    );
  }
}

class OnBlockTest extends StatelessWidget {
  OnBlockTest({Key? key, required this.stuffModel}) : super(key: key);
  StuffModel stuffModel;

  Widget build(BuildContext context) {
    print("이 버튼이 다시 빌드 됐습니다");

    Size size = MediaQuery.of(context).size;
    double buttonHeight = size.height*0.1;

    return Container(
      child: Text(
        stuffModel.todo,
        style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontFamily: "SongMyung"
        ),
      ),
      alignment: Alignment.center,
      height: buttonHeight,
      color: Colors.transparent,
    );
  }

}


class CreateButton extends StatelessWidget {
  const CreateButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double buttonHeight = size.height*0.1;

    return Container(
      child: Icon(Icons.add, color: Colors.white,),
      alignment: Alignment.center,
      height: buttonHeight,
      color: Colors.transparent,
    );
  }
}



