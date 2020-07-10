import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            MaterialButton(child: Text('Lecturer', style: TextStyle(color: Colors.white),), onPressed: (){}, color: Colors.green),
            MaterialButton(child: Text('Student', style: TextStyle(color: Colors.white)), onPressed: (){}, color: Colors.green),
          ],
        ),
      )
    );
  }
}
