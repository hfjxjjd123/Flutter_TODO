import 'package:flutter/material.dart';
import 'package:secare/const/size.dart';

class AddTaskTab extends StatelessWidget {
  const AddTaskTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SIZE.width,
      height: SIZE.height,
      color: Colors.black87.withOpacity(0.8),
    );
  }
}
