import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'lecturer_set_class.dart';

class AttendanceSuccess extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'iAttendance',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 100,
                          semanticLabel: 'Text to announce in accessibility modes',
                        ),
                        Text('Attendance recorded')
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
