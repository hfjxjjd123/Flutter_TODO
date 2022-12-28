import 'package:beamer/beamer.dart';
import 'package:secare/const/mid.dart';
import 'package:secare/repo/uid_service.dart';
import 'package:flutter/material.dart';
import 'package:secare/services/profile/screen_profile_edit.dart';
import 'package:secare/test/save.dart';
import 'package:secare/test/test_screen.dart';

import '../const/size.dart';
import '../screens/profile_screen.dart';

class DayLocation extends BeamLocation{
  @override
  List<BeamPage> buildPages(context, state) {
    SIZE = MediaQuery.of(context).size;

    return [
      BeamPage(
          child: FutureBuilder<String>(
            future: UidService.readDeviceInfo(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                if(snapshot.data != "not found"){
                  logger.d(snapshot.data!);
                  MID = snapshot.data!;
                }else{
                  logger.d("User 생성!! // 1번만해야돼");
                  String mid = UidService.createUID();
                  UidService.writeDeviceInfo(mid);
                  MID = mid;
                  logger.d("created mid = $mid");

                }
              }else{
                return Container();
              }

              return DayScreen();
            }
          ),
          key: ValueKey('day')
      ),
    ];
  }

  @override
  List get pathBlueprints => ["/day"];
}

class ProfileLocation extends BeamLocation{
  @override
  List<BeamPage> buildPages(context, state) {
    SIZE = MediaQuery.of(context).size;

    return [
    BeamPage(
        child: ProfileScreen(),
        key: ValueKey('profile')
    ),
    ];
  }

  @override
  List get pathBlueprints => ["/profile"];
}

class ProfileEditLocation extends BeamLocation{
  @override
  List<BeamPage> buildPages(context, state) {
    SIZE = MediaQuery.of(context).size;

    return [
      BeamPage(
          child: ProfileEditScreen(),
          key: ValueKey('profile_edit')
      ),
    ];
  }

  @override
  List get pathBlueprints => ["/profile_edit"];
}
