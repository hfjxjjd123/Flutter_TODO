import 'package:beamer/beamer.dart';
import 'package:secare/const/home_directory.dart';
import 'package:secare/const/mid.dart';
import 'package:secare/repo/get_homedir.dart';
import 'package:secare/repo/uid_service.dart';
import 'package:flutter/material.dart';
import 'package:secare/screens/day_screen.dart';
import 'package:secare/services/profile/screen_profile_edit.dart';
import 'package:secare/test/test_screen.dart';

import '../const/size.dart';
import '../screens/profile_screen.dart';

class DayLocation extends BeamLocation{
  @override
  List<BeamPage> buildPages(context, state) {
    SIZE = MediaQuery.of(context).size;

    return [
      BeamPage(
          child: DayScreen(),
          key: const ValueKey('day')
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
        key: const ValueKey('profile')
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
          key: const ValueKey('profile_edit')
      ),
    ];
  }

  @override
  List get pathBlueprints => ["/profile_edit"];
}
