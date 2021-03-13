import 'package:flutter/material.dart';

class DashboardLocation extends StatelessWidget {
  const DashboardLocation({
    Key key,
    @required this.locationTitle,
  }) : super(key: key);

  final String locationTitle;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {},
      child: Row(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Icon(Icons.place),
          ),
          Container(
            width: 290,
            margin: EdgeInsets.only(left: 10),
            child: Text(
              locationTitle,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}
