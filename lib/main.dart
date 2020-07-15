import 'package:flutter/material.dart';
import 'home.dart';
import 'onboarding.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
// dev
//import 'onboarding_success.dart';

// file io functions
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/user_type.txt');
}

Future<String> readFromDevice() async {
  try {
    final file = await _localFile;
    // Read the file.
    String contents = await file.readAsString();

    return contents;
  } catch (e) {
    // If encountering an error, return 0.
    return 'error';
  }
}
void main() async{
  // statusbar white text
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
  ));
  // need this line to prevent error
  WidgetsFlutterBinding.ensureInitialized();

  String s = await readFromDevice();

  // do onboarding
  if (s == 'error'){
    // prevent rotation
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
      runApp(MyApp());
    });
  }
  // onboarding not needed
  else{
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
    return MaterialApp(debugShowCheckedModeBanner: false, home: Onboarding()
        );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()
    );
  }
}
