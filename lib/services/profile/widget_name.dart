import 'package:flutter/material.dart';
import 'package:secare/const/size.dart';

class WidgetName extends StatelessWidget {
  const WidgetName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String name = "이학림";
    String job = "개발자";

    return Container(
      child: Text('$name $job 님', style: Theme.of(context).textTheme.headline3,),
      width: SIZE.width,
      height: SIZE.height*0.08,
      color: Colors.transparent,
      alignment: Alignment.center,
    );
  }
}
