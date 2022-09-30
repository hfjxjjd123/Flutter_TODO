import 'package:flutter/material.dart';
import 'package:secare/data/stuff_model.dart';
import 'package:secare/provider/onclick_notifier.dart';
import 'package:secare/repo/stuff_service.dart';
import 'package:secare/widgets/datetime_widget.dart';


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



class PlusButton extends StatelessWidget {
  const PlusButton({Key? key}) : super(key: key);

  Future attemptUploadStuffs() async{
    String day = DateView.getDate();
    String todo = '123';
    String stuffId = day+todo;

    StuffModel stuffModel = StuffModel(
    day:day, todo: todo, stuffId:stuffId,
    );

    await StuffService().uploadNewStuff(stuffModel, day, todo);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double buttonHeight = size.height*0.1;
    return InkWell(
      child: Container(
        child: Icon(Icons.add, color: Colors.white,),
        alignment: Alignment.center,
        height: buttonHeight,
        color: Colors.transparent,
      ),
      onTap: (){
        attemptUploadStuffs();
      },
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



class UpdateButton extends StatefulWidget {
  const UpdateButton({Key? key}) : super(key: key);

  @override
  State<UpdateButton> createState() => _UpdateButtonState();
}

class _UpdateButtonState extends State<UpdateButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double buttonHeight = size.height*0.1;
    return Container(
      height: buttonHeight,
        color:  Color.fromARGB(255, 88, 212, 183),
    );
  }
}



