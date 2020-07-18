import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:iattendance/student_view_classes.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'lecturer_set_class.dart';

class HomePage extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,

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
                          Icons.content_paste,
                          color: Colors.green,
                          size: 100,
                          semanticLabel: 'Text to announce in accessibility modes',
                        ),
                        Text('Ready to take attendance?')
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: CupertinoButton(
                      child: Text('Start', style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        var s = await readFromDevice();
                        if(s == 'student'){
                          // show student page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewClasses()),
                          );

                        }
                        else{
                          // show lecturer page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SetClass()),
                          );
                        }
                      },
                      color: Colors.green),
                ),
              ],
            ),
          ),
        ));
  }
}
