import 'package:flutter/material.dart';
import 'package:flutter_presensi_uajy/src/data/model/profile.dart';
import 'package:flutter_presensi_uajy/src/data/remote/auth_service.dart';
import 'package:flutter_presensi_uajy/src/screen/login/login_screen.dart';
import 'package:flutter_presensi_uajy/src/widget/app_bar_home.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({
    Key key,
    @required this.profile,
  }) : super(key: key);

  final Profile profile;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        AppBarHome(
          avatar: widget.profile.profile_picture,
          title: widget.profile.name,
          subtitle: widget.profile.nim,
        ),
        SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: () {
            AuthService().logout().whenComplete(
                  () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  ),
                );
          },
          child: Text("Logout"),
        ),
      ],
    ));
  }
}
