import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_presensi_uajy/src/screen/asset/asset_screen.dart';
import 'package:flutter_presensi_uajy/src/screen/home/home_screen.dart';
import 'package:flutter_presensi_uajy/src/screen/splash/splash_screen.dart';
import 'dart:io' show Platform;

class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Presensi UAJY',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container(
              child: Center(
                child: Text(snapshot.error),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return SplashScreen();
            // return AssetScreen();
          }

          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
