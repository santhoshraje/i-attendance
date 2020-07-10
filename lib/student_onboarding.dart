import 'package:flutter/material.dart';
import 'onboarding_success.dart';

class StudentOnboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('iAttendance'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            MaterialButton(child: Text('Submit', style: TextStyle(color: Colors.white)), onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OnboardingSuccess()),
              );
            }, color: Colors.green),],
        ),
      )
    );
  }
}
