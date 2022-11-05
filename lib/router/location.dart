import 'package:beamer/beamer.dart';
import 'package:provider/provider.dart';
import 'package:secare/provider/onclick_notifier.dart';
import 'package:secare/repo/stuff_service.dart';
import 'package:secare/screens/day_screen.dart';
import 'package:flutter/material.dart';
import 'package:secare/test/bloc.dart';
import 'package:secare/test/test_screen.dart';

import '../const/size.dart';

class DayLocation extends BeamLocation{
  @override
  List<BeamPage> buildPages(context, state) {
    SIZE = MediaQuery.of(context).size;
    print("daylocation build");
    return [
      BeamPage(
          child: ChangeNotifierProvider<OnclickNotifier>(
              create: (BuildContext context) { return OnclickNotifier(); },
              child: DayScreen(),
          ),
          key: ValueKey('day')
      ),
    ];
  }

  @override
  List get pathBlueprints => ["/day"];
}

class TestLocation extends BeamLocation{
  @override
  List<BeamPage> buildPages(context, state) {
    print("testlocation build!!!");
    SIZE = MediaQuery.of(context).size;
    BLOC().sinkStuffList(StuffService.getAllStuffs("2022.10.04"));
    return [
    BeamPage(
        child: TestScreen(),
        key: ValueKey('')
    ),
    ];
  }

  @override
  List get pathBlueprints => ["/"];
}

