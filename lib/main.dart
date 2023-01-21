import 'package:flutter/material.dart';
import 'package:secare/repo/get_homedir.dart';
import 'package:secare/repo/splash_time_service.dart';
import 'package:secare/repo/uid_service.dart';
import 'package:secare/router/location.dart';
import 'package:secare/screens/splash_screen.dart';
import 'package:beamer/beamer.dart';
import 'package:secare/test/test_screen.dart';
import 'const/home_directory.dart';
import 'const/mid.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const SelfCareApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'umm',
      theme: ThemeData(
        textTheme: TextTheme(
          headline3:
              TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'Jua'),
          headline4:
              TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Jua'),
          headline6:
              TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'Jua'),
        ),
      ),
      routeInformationParser: BeamerParser(),
      routerDelegate: _routerDelegate,
      backButtonDispatcher:
          BeamerBackButtonDispatcher(delegate: _routerDelegate),
    );
  }
}

class SelfCareApp extends StatelessWidget {
  const SelfCareApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

          return FutureBuilder<List<String>>(
            future: Future.wait(
                [GetHomedir.getHome(), UidService.readDeviceInfo(), SplashTimeService.delay()]),
            builder: (context, AsyncSnapshot<List<String>> snapshot) {
              if (snapshot.hasData) {
                HOME = snapshot.data![0];

                if (snapshot.data![1] != "not found") {
                  MID = snapshot.data![1];
                } else {
                  //User 생성
                  String mid = UidService.createUID();
                  UidService.writeDeviceInfo(mid);
                  MID = mid;
                }

                return const MyApp();
              } else {
                return const SplashScreen();
              }
            },
          );
  }
}

BeamerDelegate _routerDelegate = BeamerDelegate(
  locationBuilder: BeamerLocationBuilder(
      beamLocations: [DayLocation(), ProfileLocation(), ProfileEditLocation()]),
);
