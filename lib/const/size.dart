import 'package:flutter/material.dart';

late Size SIZE;

Widget columnBigPadding(){
  return Container(height: SIZE.height*0.03,);
}
Widget columnSmallPadding(){
  return Container(height: SIZE.height*0.01,);
}

double buttonHeight = SIZE.height*0.1;