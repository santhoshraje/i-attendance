import 'package:flutter/material.dart';
import 'package:iattendance/file_manager.dart';
import 'home.dart';
import 'onboarding.dart';
import 'package:flutter/services.dart';

void main() async {
  final fileManager = FileManager();
  // statusbar white text
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
  ));
  // need this line to prevent error
  WidgetsFlutterBinding.ensureInitialized();

  String s = await fileManager.readFromDevice('user_type.txt');

  // do onboarding
  if (s == 'error') {
    // prevent rotation
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
      runApp(MyApp());
    });
  }
  // onboarding not needed
  else {
    // prevent rotation
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
      runApp(Home());
    });
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Onboarding());
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}
