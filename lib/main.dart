
import 'package:flutter/material.dart';
import 'onboarding.dart';
import 'package:flutter/services.dart';

void main() {
  // need this line to prevent error
  WidgetsFlutterBinding.ensureInitialized();
  // prevent rotation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Onboarding()
    );
  }
}
