import 'dart:io';

import 'package:flutter/material.dart';
import 'package:secare/router/location.dart';
import 'package:secare/screens/day_screen.dart';
import 'package:secare/screens/splash_screen.dart';
import 'package:beamer/beamer.dart';
import 'package:firebase_core/firebase_core.dart';
import '../const/size.dart';

void main(){
  runApp(SelfCareApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'umm',
      routeInformationParser: BeamerParser(),
      routerDelegate: _routerDelegate,
    );
  }
}

class SelfCareApp extends StatelessWidget {
  const SelfCareApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        return FutureBuilder(
          future: Future.delayed(Duration(milliseconds: 500),()=>100),
            builder: (context, snapshot){
            if(snapshot.hasData){
              return MyApp();
            } else return SplashScreen();
            },
        );
      }
    );
  }


}



BeamerDelegate _routerDelegate = BeamerDelegate(
  locationBuilder: BeamerLocationBuilder(
      beamLocations: [DayLocation(),TestLocation()]),
);