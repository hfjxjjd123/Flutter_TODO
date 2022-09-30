import 'dart:async';
import 'package:flutter/material.dart';
import 'package:secare/data/stuff_model.dart';
import 'package:secare/test/test_button.dart';
import '../const/colors.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinearProgressIndicator(
          color: fadeColor,
          backgroundColor: Colors.transparent,
          value: , // 0.7 뭐 이런 진척도가 들어가면 된다.
          minHeight: 8,
        ),
        TestButton(stuffModel: StuffModel()),
        TestButton(stuffModel: StuffModel()),
        TestButton(stuffModel: StuffModel()),
      ],
    );
  }
}
