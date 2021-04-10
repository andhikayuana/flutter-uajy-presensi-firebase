import 'package:flutter/material.dart';
import 'package:flutter_presensi_uajy/src/data/model/log_activity.dart';

class CardHistory extends StatelessWidget {
  const CardHistory({
    Key key,
    @required this.log,
  }) : super(key: key);

  final LogActivity log;

  bool get _isIn => log.type == "clock_in";
  IconData get _icon => _isIn ? Icons.login : Icons.logout;
  MaterialAccentColor get _color =>
      _isIn ? Colors.greenAccent : Colors.pinkAccent;
  String get _title => _isIn ? "Masuk" : "Keluar";

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
        top: 15,
        left: 15,
        right: 15,
      ),
      elevation: 4,
      child: ListTile(
        leading: Icon(
          _icon,
          color: _color,
          size: 36,
        ),
        title: Text(
          _title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(log.loged_at.toIso8601String()),
      ),
    );
  }
}
