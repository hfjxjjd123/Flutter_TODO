import 'dart:async';
import 'package:secare/data/stuff_model.dart';

class BLOC{
  static int countStuffs= 1;
  static int countDone =0;
  static double doneProgress = 0.0;

  StreamController stuffListController = StreamController<Future<List<StuffModel>>>.broadcast();
  final streamTransformer = StreamTransformer.fromHandlers(
    handleData: (Future<List<StuffModel>> futureStuff,sink)async{
      //error checking 필요
      List<StuffModel> stuffs = await futureStuff;

      countStuffs = stuffs.length;
      countDone = 0;
      for(int i=0; i<stuffs.length; i++) {
        if (stuffs[i].isDone == true) {
          countDone++;
        }
      }
      doneProgress = countDone.toDouble()/countStuffs.toDouble();
      sink.add(stuffs);
      sink.add(doneProgress);
    }
  );

  get sinkStuffList => stuffListController.sink.add;
  get stuffListStream => stuffListController.stream
      .transform(streamTransformer).where((component)=>component is List);
  get progressStream => stuffListController.stream
      .transform(streamTransformer).where((component) => component is double);
}
