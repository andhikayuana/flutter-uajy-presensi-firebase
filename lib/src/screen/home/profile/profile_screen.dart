import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_presensi_uajy/src/data/model/profile.dart';
import 'package:flutter_presensi_uajy/src/data/remote/auth_service.dart';
import 'package:flutter_presensi_uajy/src/data/remote/database_service.dart';
import 'package:flutter_presensi_uajy/src/data/remote/storage_service.dart';
import 'package:flutter_presensi_uajy/src/screen/login/login_screen.dart';
import 'package:flutter_presensi_uajy/src/widget/app_bar_home.dart';
import 'package:image_picker/image_picker.dart';

typedef OnUpdatedProfile = Function();

class ProfileScreen extends StatefulWidget {
  ProfileScreen({
    Key key,
    @required this.profile,
    @required this.onUpdatedProfile,
  }) : super(key: key);

  final Profile profile;
  final OnUpdatedProfile onUpdatedProfile;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  final StorageService _storageService = StorageService();
  final DatabaseService _databaseService = DatabaseService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        //
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.purpleAccent,
                  Colors.purple,
                ]),
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.elliptical(100, 50),
            ),
          ),
          child: Container(
            width: double.infinity,
            height: 350,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  overflow: Overflow.visible,
                  children: [
                    CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                          widget.profile.profile_picture),
                      radius: 60,
                    ),
                    Positioned(
                      bottom: -10,
                      right: -20,
                      child: RaisedButton(
                        onPressed: onPressedChangePhoto,
                        shape: CircleBorder(),
                        child: Icon(Icons.camera_alt),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.profile.name,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
                Text(
                  widget.profile.nim,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: onPressedLogout,
          child: Text("Logout"),
        ),
      ],
    ));
  }

  void onPressedChangePhoto() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
            child: Container(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text("Camera"),
                onTap: onTapChangePhotoCamera,
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text("Gallery"),
                onTap: onTapChangePhotoGallery,
              ),
            ],
          ),
        ));
      },
    );
  }

  Future<void> onTapChangePhotoCamera() async {
    final PickedFile pickedFile = await _imagePicker.getImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );
    final String fileName = "profile_picture.jpg";
    final String ref = "${_authService.user.uid}/profile/$fileName";
    final String url = await _storageService.uploadFile(pickedFile.path, ref);

    final newProfile = widget.profile.copyWith(profile_picture: url);
    await _databaseService.updateProfile(newProfile);
    widget.onUpdatedProfile();

    Navigator.pop(context);
  }

  Future<void> onTapChangePhotoGallery() async {
    final PickedFile pickedFile = await _imagePicker.getImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    final String fileName = "profile_picture.jpg";
    final String ref = "${_authService.user.uid}/profile/$fileName";
    final String url = await _storageService.uploadFile(pickedFile.path, ref);

    final newProfile = widget.profile.copyWith(profile_picture: url);
    await _databaseService.updateProfile(newProfile);
    widget.onUpdatedProfile();

    Navigator.pop(context);
  }

  void onPressedLogout() {
    final AlertDialog dialog = AlertDialog(
      title: const Text("Logout"),
      content: const Text("Anda yakin ingin keluar ?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Batal"),
        ),
        TextButton(
          onPressed: () {
            AuthService().logout().whenComplete(
                  () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  ),
                );
          },
          child: const Text("OK"),
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (context) => dialog,
    );
  }
}
