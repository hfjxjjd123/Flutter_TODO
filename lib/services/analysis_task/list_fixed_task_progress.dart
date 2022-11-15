import 'package:flutter/material.dart';
import 'package:secare/const/size.dart';

class ListFixedTaskProgress extends StatelessWidget {
  ListFixedTaskProgress({Key? key}) : super(key: key);

  List<String> tasks = ["데일리스크럼", "백준 1문제", "운동"];
  List<String> pro = ["100","90.6","64.7"];
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: SIZE.height *0.15,
      child: ListView.builder(
        itemCount: tasks.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              Expanded(
                flex: 3,
                child: Center(
                  child: Text(tasks[index], style: Theme
                      .of(context)
                      .textTheme
                      .headline4,),
                ),
              ),
              Container(
                color: Colors.white,
                width: 2,
                height: 16,
              ),
              Expanded(
                flex: 2,
                child: Center(child: Text(pro[index]+"%", style: Theme.of(context).textTheme.headline4,)),
              ),
            ],
          );
        }
      ),
    );
  }
}
