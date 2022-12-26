import 'package:flutter/material.dart';

class DailyPage extends StatefulWidget {
  const DailyPage({Key? key}) : super(key: key);

  @override
  State<DailyPage> createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: Column(
        children: [
          Text('07.16'),
          Divider(height: 1, thickness: 1, color: Colors.white,),
          Text('프로그래밍 작업'),
          Text('운동'),
          Divider(height: 1, thickness: 1, color: Colors.white,),
          Text('프로그래밍 작업'),
        ],
      ),
    );
  }
}
