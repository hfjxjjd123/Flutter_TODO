import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:secare/const/colors.dart';

class WidgetTotalProgresser extends StatelessWidget {
  const WidgetTotalProgresser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width*0.6,
      height: size.width*0.1,
      child: LiquidLinearProgressIndicator(
        value: 0.7,
        valueColor: AlwaysStoppedAnimation(onColor),
        borderWidth: 0,
        borderColor: splashColor,
        backgroundColor: Colors.white,
        borderRadius: 5,
      ),
    );
  }
}
