import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../file_manager.dart';
import 'lecturer_view_students.dart';
import 'package:flutter/cupertino.dart';
import 'package:beacon_broadcast/beacon_broadcast.dart';
import 'package:flutter_blue/flutter_blue.dart'; // check for bluetooth on

class SetClass extends StatefulWidget {
  @override
  _SetClassState createState() => _SetClassState();
}

class _SetClassState extends State<SetClass> {
  final myController = TextEditingController();
  BeaconBroadcast beaconBroadcast = BeaconBroadcast();
  FlutterBlue flutterBlue = FlutterBlue.instance;
  final fileManager = FileManager();
  Random random = Random();
  int _id;

  @override
  void initState() {
    // TODO: implement initState
    _id = random.nextInt(65534);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          Icons.event_note,
                          color: Colors.green,
                          size: 100,
                          semanticLabel:
                              'Text to announce in accessibility modes',
                        ),
                        Container(
                          width: 200,
                          child: TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Enter class name'),
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
                      child:
                          Text('Next', style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        // check if bluetooth enabled
                        if (await flutterBlue.isOn) {
                          // save class data
                          fileManager.writeToDevice(myController.text, 'class_name.txt');
                          // start broadcast
                          beaconBroadcast
                              .setUUID(
                                  'E2C56DB5-DFFB-48D2-B060-D0F5A71096E0') //change UUID to yours
                              .setMajorId(1) //change major id to yours
                              .setMinorId(_id) //change minor id to yours
                              .setLayout(
                                  'm:2-3=0215,i:4-19,i:20-21,i:22-23,p:24-24')
                              .setManufacturerId(0x004c)
                              .start();
//                          // change page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewStudents()),
                          );

                          // store class name and beacon id
                          Firestore.instance.collection('beacons').document()
                              .setData({ 'id': _id, 'class': myController.text });
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // return object of type Dialog
                              return CupertinoAlertDialog(
                                title: new Text("Please turn on bluetooth"),
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
                      },
                      color: Colors.green),
                ),
              ],
            ),
          ),
        ));
  }
}
