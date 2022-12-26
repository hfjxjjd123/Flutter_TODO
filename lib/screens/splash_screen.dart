import 'package:flutter/material.dart';
import 'package:secare/const/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        color: onColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('오늘도',textDirection: TextDirection.ltr,style: TextStyle(fontFamily: "SongMyung", fontSize: 24),),
            Container(height: 6,),
            Text('힘내보자',textDirection: TextDirection.ltr,style: TextStyle(fontFamily: "SongMyung", fontSize: 24),),
          ],
        ),
      ),
    );
  }
}
