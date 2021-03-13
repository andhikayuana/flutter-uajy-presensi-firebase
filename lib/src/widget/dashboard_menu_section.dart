import 'package:flutter/material.dart';

class DashboardMenuSection extends StatelessWidget {
  const DashboardMenuSection({
    Key key,
    @required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: Colors.black54,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );
  }
}
