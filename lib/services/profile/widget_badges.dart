import 'package:flutter/material.dart';
import 'package:secare/const/size.dart';
import 'package:secare/const/size.dart';
import 'package:secare/const/size.dart';
import 'package:secare/const/size.dart';
import 'package:secare/const/size.dart';
import 'package:secare/const/size.dart';
import 'package:secare/const/size.dart';

class WidgetBadges extends StatelessWidget {
  const WidgetBadges({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.local_fire_department, color: Colors.red,size: SIZE.width*0.08,),
        Container(width: SIZE.width * 0.03,),
        Text('구현중..',style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: SIZE.width*0.05),),
        Container(width: SIZE.width * 0.03,),
        Icon(Icons.nightlight, color: Colors.amber,size: SIZE.width*0.08,),
      ],
    );
  }
}
