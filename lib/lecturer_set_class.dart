import 'package:flutter/material.dart';
import 'lecturer_view_students.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:beacon_broadcast/beacon_broadcast.dart';
import 'package:flutter_blue/flutter_blue.dart';

class SetClass extends StatelessWidget {
  final myController = TextEditingController();
  BeaconBroadcast beaconBroadcast = BeaconBroadcast();
  FlutterBlue flutterBlue = FlutterBlue.instance;
  var _id = 10;

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
//                        // check if bluetooth enabled
//                        if (await flutterBlue.isOn) {
//                          // start broadcast
//                          beaconBroadcast
//                              .setUUID(
//                                  'E2C56DB5-DFFB-48D2-B060-D0F5A71096E0') //change UUID to yours
//                              .setMajorId(1) //change major id to yours
//                              .setMinorId(_id) //change minor id to yours
//                              .setLayout(
//                                  'm:2-3=0215,i:4-19,i:20-21,i:22-23,p:24-24')
//                              .setManufacturerId(0x004c)
//                              .start();
//                          // change page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewStudents()),
                          );
//
//                          // store class name and beacon id
//                          Firestore.instance.collection('beacons').document()
//                              .setData({ 'id': _id, 'class': myController.text });
//
////                          Firestore.instance
////                              .collection('beacons')
////                              .where("class", isEqualTo: "hi")
////                              .snapshots()
////                              .listen((data) =>
////                              data.documents.forEach((doc) => print(doc["id"])));
//
//                        } else {
//                          showDialog(
//                            context: context,
//                            builder: (BuildContext context) {
//                              // return object of type Dialog
//                              return CupertinoAlertDialog(
//                                title: new Text("Please turn on bluetooth"),
//                                actions: <Widget>[
//                                  // usually buttons at the bottom of the dialog
//                                  new FlatButton(
//                                    child: new Text("Close"),
//                                    onPressed: () {
//                                      Navigator.of(context).pop();
//                                    },
//                                  ),
//                                ],
//                              );
//                            },
//                          );
//                        }
                      },
                      color: Colors.green),
                ),
              ],
            ),
          ),
        ));
  }
}
