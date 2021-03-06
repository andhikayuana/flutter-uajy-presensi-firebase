import 'package:flutter/material.dart';
import 'package:flutter_presensi_uajy/src/data/model/profile.dart';
import 'package:flutter_presensi_uajy/src/data/remote/auth_service.dart';
import 'package:flutter_presensi_uajy/src/data/remote/database_service.dart';
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

  @override
  void initState() {
    super.initState();
    _getProfile = dbService.getProfile(authService.user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Presensi UAJY"),
      ),
      body: Container(
        child: Center(
          child: FutureBuilder(
            future: _getProfile,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error);
              }

              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                final profile = snapshot.data as Profile;

                return Column(
                  children: [
                    Image.network(profile.profile_picture),
                    Text(
                      "${authService.user.email}",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "${profile.name}",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        authService.logout();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: Text("Logout"),
                    ),
                  ],
                );
              }

              return CircularProgressIndicator();
            },
          ),
          // child: Column(
          //   children: [
          //     Text(
          //       "${authService.user.email}",
          //       style: TextStyle(
          //         fontSize: 20,
          //       ),
          //     ),
          //     Text(
          //       "halo",
          //       style: TextStyle(
          //         fontSize: 20,
          //       ),
          //     ),
          //     ElevatedButton(
          //       onPressed: () {
          //         authService.logout();
          //         Navigator.of(context).pushReplacement(
          //           MaterialPageRoute(
          //             builder: (context) => LoginScreen(),
          //           ),
          //         );
          //       },
          //       child: Text("Logout"),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
