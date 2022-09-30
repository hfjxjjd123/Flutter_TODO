import 'package:beamer/beamer.dart';
import 'package:provider/provider.dart';
import 'package:secare/provider/onclick_notifier.dart';
import 'package:secare/screens/day_screen.dart';
import 'package:flutter/material.dart';

class DayLocation extends BeamLocation{
  @override
  List<BeamPage> buildPages(context, state) {
    return [
      BeamPage(
          child: ChangeNotifierProvider<OnclickNotifier>(
              create: (BuildContext context) { return OnclickNotifier(); },
              child: DayScreen(),
          ),
          key: ValueKey('day')
      )
    ];
  }

  @override
  List get pathBlueprints => ["/"];
}