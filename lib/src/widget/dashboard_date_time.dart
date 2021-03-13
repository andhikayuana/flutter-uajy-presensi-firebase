import 'package:flutter/material.dart';

class DashboardDateTime extends StatelessWidget {
  const DashboardDateTime({
    Key key,
    @required this.value,
    @required this.icon,
  }) : super(key: key);

  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Icon(icon),
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 14,
          ),
        )
      ],
    );
  }
}
