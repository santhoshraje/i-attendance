import 'package:flutter/material.dart';
import '../onboarding_success.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class LecturerOnboarding extends StatelessWidget {
  final myController = TextEditingController();

  // file io functions
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/user_type.txt');
  }

  Future<File> writeToDevice(String s) async {
    final file = await _localFile;
    // Write the file.
    return file.writeAsString(s);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
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
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.lock_outline,
                          color: Colors.green,
                          size: 100,
                          semanticLabel: 'Text to announce in accessibility modes',
                        ),
                        Container(
                          width: 200,
                          child: TextFormField(
                              maxLength: 6,
                              obscureText: true,
                              decoration: InputDecoration(labelText: 'Enter pin'),
                              keyboardType: TextInputType.number,
                              controller: myController,

                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: CupertinoButton(
                      child: Text('Submit', style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        if (myController.text.isEmpty){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // return object of type Dialog
                              return CupertinoAlertDialog(
                                title: new Text("Invalid pin"),
                                actions: <Widget>[
                                  // usually buttons at the bottom of the dialog
                                  new FlatButton(
                                    child: new Text("Close"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                        else{
                          Firestore.instance
                              .collection('pins')
                              .document(myController.text)
                              .get()
                              .then((DocumentSnapshot ds) async {
                            if (ds.exists){
                              // write to device
                              await writeToDevice('lecturer');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OnboardingSuccess()),
                              );
                            }
                            else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  // return object of type Dialog
                                  return CupertinoAlertDialog(
                                    title: new Text("Invalid pin"),
                                    actions: <Widget>[
                                      // usually buttons at the bottom of the dialog
                                      new FlatButton(
                                        child: new Text("Close"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                            // use ds as a snapshot
                          });
                        }
                      },
                      color: Colors.green),
                ),
              ],
            ),
          )),
    );
  }
}
