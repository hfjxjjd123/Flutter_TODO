import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:secare/data/stuff_model.dart';
import 'package:secare/repo/stuff_service.dart';
import 'package:secare/test/bloc.dart';
import 'package:secare/test/test_button.dart';
import 'package:secare/widgets/datetime_widget.dart';
import '../const/colors.dart';
import '../const/size.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

var loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
);

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BLOC().sinkStuffList(StuffService.getAllStuffs("2022. 10. 04"));
    logger.d(BLOC().stuffListStream.runtimeType);
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Container(
            color: offColor,
            child: Column(
              children: [
                // StreamBuilder<double>(
                //   initialData: 0,
                //   stream: BLOC().progressStream,
                //   builder: (context, snapshot){
                //     if(snapshot.hasData) {
                //       return LinearProgressIndicator(
                //         color: fadeColor,
                //         backgroundColor: Colors.transparent,
                //         value: snapshot.data,
                //         minHeight: 8,
                //       );
                //     } else return Container(child: Text("initial not yet"),);
                //   }
                // ),
                columnBigPadding(),
                DateView(),
                columnSmallPadding(),
                StreamBuilder<List<StuffModel>>(
                  initialData: [StuffModel(day: "2022. 10. 04", todo: 'Hi', stuffId: "2022. 10. 04Hi")],
                  stream: BLOC().stuffListStream,
                  builder: (context, snapshot){
                    if(!snapshot.hasData){
                      return Container(color: Colors.greenAccent,);
                    } else {
                      return SizedBox(
                        height: SIZE.height*0.75,
                        child: ListView.builder(
                          itemCount: (snapshot.data!.length),
                          itemBuilder: (BuildContext context, int index) {
                            return TestButton(stuffModel: snapshot.data![index]);
                          },
                        ),
                      );
                    }
                  }

                ),
                // TestButton(stuffModel: StuffModel()),
                // TestButton(stuffModel: StuffModel()),
                // TestButton(stuffModel: StuffModel()),
              ],
            ),
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
