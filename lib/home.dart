import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:iattendance/student/student_view_classes.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'lecturer/lecturer_set_class.dart';

class HomePage extends StatelessWidget {
  bool authorizationStatusOk = false;

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
                          semanticLabel:
                              'Text to announce in accessibility modes',
                        ),
                        Text('Ready to take attendance?')
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: CupertinoButton(
                      child:
                          Text('Start', style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        var s = await readFromDevice();
                        if (s == 'student') {
                          // check ble scanner permissions
                          final authorizationStatus =
                              await flutterBeacon.authorizationStatus;
                          final authorizationStatusOk = authorizationStatus ==
                                  AuthorizationStatus.allowed ||
                              authorizationStatus == AuthorizationStatus.always;
                          // show pop up here to request authorization
                          if (!authorizationStatusOk) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                // return object of type Dialog
                                return CupertinoAlertDialog(
                                  title: new Text(
                                      "Please allow permissions for this app to function correctly."),
                                  actions: <Widget>[
                                    // usually buttons at the bottom of the dialog
                                    new FlatButton(
                                      child: new Text("Authorise"),
                                      onPressed: () async {
                                        await flutterBeacon
                                            .requestAuthorization;
                                        Navigator.of(context).pop();

                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            bool bluetoothEnabled = false;
                            final bluetoothState =
                                await flutterBeacon.bluetoothState;
                            bluetoothEnabled =
                                bluetoothState == BluetoothState.stateOn;

                            if (!bluetoothEnabled) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  // return object of type Dialog
                                  return CupertinoAlertDialog(
                                    title: new Text("Please enable bluetooth."),
                                    actions: <Widget>[
                                      // usually buttons at the bottom of the dialog
                                      new FlatButton(
                                        child: new Text("Ok"),
                                        onPressed: () async {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              bool locationServiceEnabled = await flutterBeacon
                                  .checkLocationServicesIfEnabled;
                              if (!locationServiceEnabled) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    // return object of type Dialog
                                    return CupertinoAlertDialog(
                                      title: new Text(
                                          "Please enable location services."),
                                      actions: <Widget>[
                                        // usually buttons at the bottom of the dialog
                                        new FlatButton(
                                          child: new Text("Ok"),
                                          onPressed: () async {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
//                                 show student page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewClasses()),
                                );
                              }
                            }
                          }
                        } else {
                          // show lecturer page
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SetClass()),
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
