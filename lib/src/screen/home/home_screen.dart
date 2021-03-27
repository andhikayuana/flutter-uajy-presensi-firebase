import 'package:flutter/material.dart';
import 'package:flutter_presensi_uajy/src/data/model/profile.dart';
import 'package:flutter_presensi_uajy/src/data/remote/auth_service.dart';
import 'package:flutter_presensi_uajy/src/data/remote/database_service.dart';
import 'package:flutter_presensi_uajy/src/screen/home/dashboard/dashboard_screen.dart';
import 'package:flutter_presensi_uajy/src/screen/home/history/history_screen.dart';
import 'package:flutter_presensi_uajy/src/screen/home/profile/profile_screen.dart';
import 'package:flutter_presensi_uajy/src/screen/login/login_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final authService = AuthService();
  final dbService = DatabaseService();

  Future<Profile> _getProfile;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _getProfile = dbService.getProfile(authService.user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _getProfile,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final profile = snapshot.data as Profile;

            List<Widget> _screens = [
              DashboardScreen(
                profile: profile,
              ),
              HistoryScreen(
                profile: profile,
              ),
              ProfileScreen(
                profile: profile,
                onUpdatedProfile: () {
                  setState(() {
                    _getProfile = dbService.getProfile(authService.user.uid);
                  });
                },
              ),
            ];

            return _screens[_currentIndex];
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error..."),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("Flutter Presensi UAJY"),
    //   ),
    //   body: Container(
    //     child: Center(
    //       child: FutureBuilder(
    //         future: _getProfile,
    //         builder: (context, snapshot) {
    //           if (snapshot.hasError) {
    //             return Text(snapshot.error);
    //           }

    //           if (snapshot.hasData &&
    //               snapshot.connectionState == ConnectionState.done) {
    //             final profile = snapshot.data as Profile;

    //             return Column(
    //               children: [
    //                 Image.network(profile.profile_picture),
    //                 Text(
    //                   "${authService.user.email}",
    //                   style: TextStyle(
    //                     fontSize: 20,
    //                   ),
    //                 ),
    //                 Text(
    //                   "${profile.name}",
    //                   style: TextStyle(
    //                     fontSize: 20,
    //                   ),
    //                 ),
    //                 ElevatedButton(
    //                   onPressed: () {
    //                     authService.logout();
    //                     Navigator.of(context).pushReplacement(
    //                       MaterialPageRoute(
    //                         builder: (context) => LoginScreen(),
    //                       ),
    //                     );
    //                   },
    //                   child: Text("Logout"),
    //                 ),
    //               ],
    //             );
    //           }

    //           return CircularProgressIndicator();
    //         },
    //       ),
    //     ),
    //   ),
    // );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      onTap: (value) {
        setState(() {
          _currentIndex = value;
        });
      },
      currentIndex: _currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: "Dashboard",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: "History",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_box),
          label: "Profile",
        ),
      ],
    );
  }
}
