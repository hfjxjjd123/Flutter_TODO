import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import '../const/size.dart';
import '../services/analysis_task/list_fixed_task_progress.dart';
import '../services/analysis_task/panel_report.dart';
import '../services/analysis_task/widget_total_progresser.dart';
import '../services/profile/widget_badges.dart';
import '../services/profile/widget_name.dart';
import '../const/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  Container(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: offColor,
              child: SafeArea(
                child: Column(
                  children: [
                    Row(
                      children: [
                        FloatingActionButton(
                          elevation: 0,
                          heroTag: "b1",
                          onPressed: () {
                            Beamer.of(context).beamBack();
                            },
                          backgroundColor: Colors.transparent,
                                  child: const Icon(Icons.arrow_back_ios, color: Colors.white,),
                        ),
                        Expanded(child: Container()),
                        FloatingActionButton(
                          elevation: 0,
                          heroTag: "b2",
                          onPressed: () {
                            Beamer.of(context).beamToNamed('/profile_edit');
                          },
                          backgroundColor: Colors.transparent,
                          child: const Icon(Icons.edit, color: Colors.white,),
                        ),
                      ],
                    ),
                    Container(
                      width: SIZE.width,
                      height: SIZE.height*0.03,
                      color: Colors.transparent,
                    ),
                    WidgetName(),// name panel
                    WidgetBadges(), // badge panel
                    Container(height: SIZE.height*0.03,),
                    WidgetTotalProgresser(),//progresser
                    Container(height: SIZE.height * 0.03,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: ListFixedTaskProgress(),

                    ),
                  ],
                ),
              ),
            ),
            PanelReport(),
          ],
        ),

      ),
    );
  }
}