import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_presensi_uajy/src/data/model/location.dart';
import 'package:flutter_presensi_uajy/src/data/model/log_activity.dart';
import 'package:flutter_presensi_uajy/src/data/model/profile.dart';
import 'package:flutter_presensi_uajy/src/data/remote/database_service.dart';
import 'package:flutter_presensi_uajy/src/data/remote/location_service.dart';
import 'package:flutter_presensi_uajy/src/widget/app_bar_home.dart';
import 'package:flutter_presensi_uajy/src/widget/dashboard_date_time.dart';
import 'package:flutter_presensi_uajy/src/widget/dashboard_location.dart';
import 'package:flutter_presensi_uajy/src/widget/dashboard_menu_section.dart';
import 'package:geocoder/geocoder.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({
    Key key,
    @required this.profile,
  }) : super(key: key);

  final Profile profile;

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  LocationService _locationService = LocationService();
  Future<Location> _getCurrentAddress;
  DatabaseService _databaseService = DatabaseService();

  Timer _timer;
  String _formattedDate;
  String _formattedTime;
  Location _location;

  @override
  void initState() {
    super.initState();
    _getCurrentAddress = _locationService.getCurrentLocation();
    _formattedDate = _formatDate(DateTime.now());
    _formattedTime = _formatTime(DateTime.now());
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _formattedTime = _formatTime(DateTime.now());
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //appbar
        Stack(
          overflow: Overflow.visible,
          children: [
            AppBarHome(
              avatar: widget.profile.profile_picture,
              title: widget.profile.name,
              subtitle: widget.profile.nim,
            ),
            buildCardDashboard(),
          ],
        ),
        SizedBox(
          height: 60,
        ),
        DashboardMenuSection(
          label: "Menu Presensi",
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(4),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.purpleAccent,
                    ),
                    onPressed: onPressedClockIn,
                    child: Row(
                      children: [
                        Expanded(
                          child: Icon(
                            Icons.login,
                            size: 25,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Masuk",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(4),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.purpleAccent,
                    ),
                    onPressed: onPressedClockOut,
                    child: Row(
                      children: [
                        Expanded(
                          child: Icon(
                            Icons.logout,
                            size: 25,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Keluar",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        DashboardMenuSection(
          label: "Pengumuman",
        ),

        //body
        Container(
          child: Center(
            child: Text(""),
          ),
        )
      ],
    );
  }

  Future<void> onPressedClockIn() async {
    final position = _location.position;
    await _databaseService.insertLogActivity(
      LogActivity(
        location: {
          "lat": position.latitude,
          "lng": position.longitude,
        },
        loged_at: DateTime.now(),
        type: "clock_in",
      ),
    );
  }

  Future<void> onPressedClockOut() async {
    final position = _location.position;
    await _databaseService.insertLogActivity(
      LogActivity(
        location: {
          "lat": position.latitude,
          "lng": position.longitude,
        },
        loged_at: DateTime.now(),
        type: "clock_out",
      ),
    );
  }

  Positioned buildCardDashboard() {
    return Positioned(
      top: 130,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
                top: 10,
                bottom: 16,
              ),
              child: Column(
                children: [
                  FutureBuilder(
                    future: _getCurrentAddress,
                    builder: (context, snapshot) {
                      String text = "Loading...";
                      if (snapshot.hasData) {
                        final location = snapshot.data as Location;
                        _location = location;
                        final address = location.address;
                        text = address.addressLine;
                      } else if (snapshot.hasError) {
                        text = "Error...";
                      }
                      return DashboardLocation(
                        locationTitle: text,
                      );
                    },
                  ),
                  Row(
                    children: [
                      DashboardDateTime(
                        icon: Icons.access_time,
                        value: _formattedTime,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      DashboardDateTime(
                        icon: Icons.calendar_today,
                        value: _formattedDate,
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  String _formatDate(DateTime now) {
    return DateFormat.yMMMEd().format(now);
  }

  String _formatTime(DateTime now) {
    return DateFormat.Hms().format(now);
  }
}
