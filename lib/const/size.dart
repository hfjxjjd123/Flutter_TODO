import 'package:flutter/material.dart';

late Size SIZE;

Widget columnBigPadding(){
  return Container(height: SIZE.height*0.05,);
}
Widget columnSmallPadding(){
  return Container(height: SIZE.height*0.02,);
}

double buttonHeight = SIZE.height*0.12;