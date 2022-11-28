import 'package:flutter/material.dart';
import 'package:secare/const/size.dart';

import '../../data/profile_model.dart';
import '../../repo/profile_edit_service.dart';

class WidgetName extends StatelessWidget {
  WidgetName({Key? key}) : super(key: key);

  String? name;
  String? job;

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<ProfileModel>(
      future: ProfileEditService.readProfile(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return Container(
            padding: EdgeInsets.symmetric(horizontal: SIZE.width*0.1),
            width: SIZE.width,
            height: SIZE.height*0.08,
            color: Colors.transparent,
            alignment: Alignment.center,
            child: Text(
              '${snapshot.data!.name} ${snapshot.data!.job} 님',
              style: Theme.of(context).textTheme.headline3,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }else{
          return Container(
            width: SIZE.width,
            height: SIZE.height*0.08,
            color: Colors.transparent,
            alignment: Alignment.center,
          );
        }

      }
    );
  }
}
