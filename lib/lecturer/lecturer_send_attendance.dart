import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:iattendance/attendance_success.dart';

class SendAttendance extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
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
                          Icons.email,
                          color: Colors.green,
                          size: 100,
                          semanticLabel: 'Text to announce in accessibility modes',
                        ),
                        Text('Ready to send your attendance to the office?')
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: CupertinoButton(
                      child: Text('Send', style: TextStyle(color: Colors.white)),
                      onPressed: () async{
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AttendanceSuccess()),
                        );
                      },
                      color: Colors.green),
                ),
              ],
            ),
          ),
        ));
  }
}
