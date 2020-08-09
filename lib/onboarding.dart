import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iattendance/lecturer/lecturer_onboarding.dart';
import 'package:iattendance/student/student_onboarding.dart';


class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                        Icons.info_outline,
                        color: Colors.green,
                        size: 100,
                        semanticLabel:
                        'Text to announce in accessibility modes',
                      ),
                      Text('Welcome to iAttendance')
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: CupertinoButton(
                    child: Text('I am a lecturer', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LecturerOnboarding()),
                      );
                    },
                    color: Colors.green),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CupertinoButton(
                    child: Text('I am a student', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudentOnboarding()),
                      );
                    },
                    color: Colors.green),
              ),
            ],
          ),
        ),
      )
    );
  }
}
