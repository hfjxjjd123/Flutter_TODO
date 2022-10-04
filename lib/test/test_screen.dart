import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:secare/data/stuff_model.dart';
import 'package:secare/repo/stuff_service.dart';
import 'package:secare/test/bloc.dart';
import 'package:secare/test/test_button.dart';
import 'package:secare/widgets/datetime_widget.dart';
import '../const/colors.dart';
import '../const/size.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              StreamBuilder<double>(
                stream: BLOC().progressStream,
                builder: (context, snapshot){
                  return LinearProgressIndicator(
                    color: fadeColor,
                    backgroundColor: Colors.transparent,
                    value: snapshot.data,
                    minHeight: 8,
                  );
                }
              ),
              columnBigPadding(),
              DateView(),
              columnSmallPadding(),
              StreamBuilder<List<StuffModel>>(
                stream: BLOC().stuffListStream,
                builder: (context, snapshot){
                  if(!snapshot.hasData){
                    return Container(color: Colors.greenAccent,);
                  } else {
                    return ListView.builder(
                      itemCount: (snapshot.data!.length),
                      itemBuilder: (BuildContext context, int index) {
                        return TestButton(stuffModel: snapshot.data![index]);
                      },
                    );
                  }
                }

              ),
              Container(color: Colors.red, height: 20,),
              Container(color: Colors.green, height: 20,),
              Container(color: Colors.yellow, height: 20,),

              // TestButton(stuffModel: StuffModel()),
              // TestButton(stuffModel: StuffModel()),
              // TestButton(stuffModel: StuffModel()),
            ],
          ),
        ),
        floatingActionButton: ExpandableFab(
            distance: 80,
            children: [
            MaterialButton(
            onPressed: (){
                StuffService.uploadNewStuff(StuffModel(day: "2022-10-04", todo: "친구생일", stuffId: "2022-10-04친구생일"));
                BLOC().sinkStuffList(StuffService.getAllStuffs("2022-10-04")); //위 두 줄 test용 이후 수정
            },
              child: Icon(Icons.add, color: Colors.white,),
              color: Theme.of(context).primaryColor,
              shape: CircleBorder(),
            ),
             MaterialButton(
               onPressed: (){
                 StuffService.deleteStuff(StuffModel(day: "2022-10-04", todo: "친구생일", stuffId: "2022-10-04친구생일"));
                 BLOC().sinkStuffList(StuffService.getAllStuffs("2022-10-04")); //위 두 줄 test용 이후 수정
               },
              child: Icon(Icons.exposure_minus_1, color: Colors.white),
              color: Theme.of(context).primaryColor,
              shape: CircleBorder(),

        ),
      ],
      ),
    ),
    );
  }
}
