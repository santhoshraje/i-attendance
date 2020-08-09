import 'package:flutter/material.dart';
import '../file_manager.dart';
import '../onboarding_success.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
class StudentOnboarding extends StatelessWidget {
  final myController = TextEditingController();
  final fileManager = FileManager();

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
                          Icons.person_pin,
                          color: Colors.green,
                          size: 100,
                          semanticLabel:
                              'Text to announce in accessibility modes',
                        ),
                        Container(
                          width: 200,
                          child: TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Enter full name'),
                            controller: myController,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text('Name cannot be changed later'))
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: CupertinoButton(
                      child:
                          Text('Submit', style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        if (myController.text.isEmpty){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // return object of type Dialog
                              return CupertinoAlertDialog(
                                title: new Text("Name cannot be blank"),
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
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // return object of type Dialog
                              return CupertinoAlertDialog(
                                title: Text("Are you sure?"),
                                content: Text('You have entered ' + myController.text + '. This cannot be changed later.'),
                                actions: <Widget>[
                                  FlatButton(
                                    child:  Text("Go back"),
                                    onPressed: () {
                                      // remove the pop up
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  // usually buttons at the bottom of the dialog
                                  FlatButton(
                                    child:  Text("Confirm"),
                                    onPressed: () async{
                                      // write to device
                                      await fileManager.writeToDevice('student', 'user_type.txt');
                                      await fileManager.writeToDevice(myController.text, 'user_name.txt');
                                      // remove the pop up
                                      Navigator.of(context).pop();
                                      // navigate to the new page
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => OnboardingSuccess()),
                                      );
                                    },
                                  ),

                                ],
                              );
                            },
                          );
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
