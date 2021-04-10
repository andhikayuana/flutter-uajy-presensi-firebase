import 'package:flutter/material.dart';
import 'package:flutter_presensi_uajy/src/data/model/log_activity.dart';
import 'package:flutter_presensi_uajy/src/data/model/profile.dart';
import 'package:flutter_presensi_uajy/src/data/remote/database_service.dart';
import 'package:flutter_presensi_uajy/src/widget/app_bar_home.dart';
import 'package:flutter_presensi_uajy/src/widget/card_history.dart';

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
  final DatabaseService _databaseService = DatabaseService();

  Future<List<LogActivity>> _getLogActivities;

  @override
  void initState() {
    super.initState();
    _getLogActivities = _databaseService.getLogActivities();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBarHome(
          avatar: widget.profile.profile_picture,
          title: widget.profile.name,
          subtitle: widget.profile.nim,
        ),
        Expanded(
          child: Container(
            child: FutureBuilder(
              future: _getLogActivities,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data as List<LogActivity>;

                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return CardHistory(log: data[index]);
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error..."),
                  );
                }

                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ],
    );
  }
}
