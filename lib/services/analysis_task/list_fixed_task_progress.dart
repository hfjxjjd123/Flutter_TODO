import 'package:flutter/material.dart';
import 'package:secare/const/size.dart';
import 'package:secare/data/fixed_analysis_model.dart';
import 'package:secare/repo/analysis_service_fixed.dart';
import 'package:secare/test/test_screen.dart';

class ListFixedTaskProgress extends StatelessWidget {
  ListFixedTaskProgress({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {



    return FutureBuilder<List<FixedAnalysisModel>>(
      future: AnalysisServiceFixed.readFixedProgress(),
      builder: (context, snapshot) {
        List<String> tasks = [];
        List<double> pro = [];
        List<String> task3 = ["---","---","---"];
        List<String> pro3 = ["--.-","--.-","--.-"];
        double progress = 0.0;

        if(snapshot.hasData){
          if(snapshot.data == null) logger.d("No fixed");
          else{
            for(FixedAnalysisModel fixedAnalysisModel in snapshot.data!){

              tasks.add(fixedAnalysisModel.todo);
              if(fixedAnalysisModel.allCounter != 0){
                pro.add((fixedAnalysisModel.doneCounter.toDouble()/fixedAnalysisModel.allCounter));
              } else{
                pro.add(0.0);
              }
            }

            int m1 = -1; int m1i = -1;
            int m2 = -1; int m2i = -1;
            int m3 = -1; int m3i = -1;
            int point = 0;

            for(int i=0; i<pro.length; i++){
              point = (pro[i]*1000).round();

              if(point>m1){
                m3 = m2; m3i = m2i;
                m2 = m1; m2i = m1i;
                m1 = point; m1i = i;
              } else if(point>m2){
                m3 = m2; m3i = m2i;
                m2 = point; m2i = i;
              } else if(point>m3){
                m3 = point; m3i = i;
              }
            }
            if(m3i != -1){
              task3[2] = tasks[m3i];
              pro3[2] = (pro[m3i]*100).toStringAsFixed(1);
              task3[1] = tasks[m2i];
              pro3[1] = (pro[m2i]*100).toStringAsFixed(1);
              task3[0] = tasks[m1i];
              pro3[0] = (pro[m1i]*100).toStringAsFixed(1);

            } else if(m2i != -1){
              task3[1] = tasks[m2i];
              pro3[1] = (pro[m2i]*100).toStringAsFixed(1);
              task3[0] = tasks[m1i];
              pro3[0] = (pro[m1i]*100).toStringAsFixed(1);

            } else if(m1i != -1){
              task3[0] = tasks[m1i];
              pro3[0] = (pro[m1i]*100).toStringAsFixed(1);
            }

          }

          return SizedBox(
            height: SIZE.height *0.15,
            child: ListView.builder(
                itemCount: 3,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: Text(task3[index], style: Theme
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
                        child: Center(child: Text(pro3[index]+"%", style: Theme.of(context).textTheme.headline4,)),
                      ),
                    ],
                  );
                }
            ),
          );
        } else{
          return Container();
          // return Shimmer();
        }
        //가장 큰 3개 정렬.
        //else shimmer


      }
    );
  }
}
