import 'package:flutter/material.dart';

class StudentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('iAttendance'),),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              MaterialButton(child: Text('Take Attendance', style: TextStyle(color: Colors.white)), onPressed: (){ }, color: Colors.green),],
          ),
        )
    );
  }
}
