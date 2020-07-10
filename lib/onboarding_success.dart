import 'package:flutter/material.dart';

class OnboardingSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('iAttendance'),),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              MaterialButton(child: Text('Start', style: TextStyle(color: Colors.white)), onPressed: (){ }, color: Colors.green),],
          ),
        )
    );
  }
}
