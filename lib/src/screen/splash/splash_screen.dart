import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_presensi_uajy/src/data/remote/auth_service.dart';
import 'package:flutter_presensi_uajy/src/screen/home/home_screen.dart';
import 'package:flutter_presensi_uajy/src/screen/login/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>
            AuthService().alreayLogin ? HomeScreen() : LoginScreen(),
      ));
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: const Alignment(0.0, 20.0),
            end: const Alignment(0.0, 0.0),
            colors: [
              Colors.deepPurple,
              Colors.purple,
            ],
          ),
        ),
        child: Center(
          child: Text(
            "Flutter Presensi UAJY",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
