import 'package:flutter/material.dart';
import 'package:secare/data/stuff_model.dart';

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

    double buttonHeight = SIZE.height*0.12;

    return Container(
      color: Colors.transparent,
      alignment: Alignment.center,
      height: buttonHeight,
      child: Center(
          child: Text(
            widget.stuff,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontFamily: "Jua"
            ),
          ),
        ),
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
            fontFamily: "Jua"
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



