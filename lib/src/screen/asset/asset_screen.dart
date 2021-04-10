import 'dart:io';

import 'package:flutter/material.dart';

class AssetScreen extends StatefulWidget {
  AssetScreen({Key key}) : super(key: key);

  @override
  _AssetScreenState createState() => _AssetScreenState();
}

class _AssetScreenState extends State<AssetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo Asset"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: [
              Image(image: AssetImage('assets/image/jarjit.jpeg')),
              Image(
                  image: AssetImage(Platform.isAndroid
                      ? 'assets/image/android-logo.png'
                      : 'assets/image/apple-logo.png')),
            ],
          ),
        ),
      ),
    );
  }
}
