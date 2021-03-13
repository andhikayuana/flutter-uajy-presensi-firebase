import 'package:flutter/material.dart';
import 'package:flutter_presensi_uajy/src/data/model/profile.dart';
import 'package:flutter_presensi_uajy/src/widget/app_bar_home.dart';

class HistoryScreen extends StatefulWidget {
  HistoryScreen({
    Key key,
    @required this.profile,
  }) : super(key: key);

  final Profile profile;

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBarHome(
          avatar: widget.profile.profile_picture,
          title: widget.profile.name,
          subtitle: widget.profile.nim,
        ),
        Container(
          child: Center(
            child: Text("hai"),
          ),
        ),
      ],
    );
  }
}
