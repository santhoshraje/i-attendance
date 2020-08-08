import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:iattendance/lecturer/lecturer_send_attendance.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ViewStudents extends StatefulWidget {
  @override
  _ViewStudentsState createState() => _ViewStudentsState();
}

class _ViewStudentsState extends State<ViewStudents> {
  final List<Map<String, String>> studentList = [];

  // file io functions
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> _localFile(String filePath) async {
    final path = await _localPath;
    return File('$path/' + filePath);
  }

  Future<String> readFromDevice(String filePath) async {
    try {
      final file = await _localFile(filePath);
      // Read the file.
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      // If encountering an error, return 0.
      return 'error';
    }
  }

  void doStuff() async {
    var className = await readFromDevice('class_name.txt');
    // get class name from firebase
    QuerySnapshot qs;
    var documentID = '';
    try {
      qs = await Firestore.instance.collection('beacons').getDocuments();
    } catch (e) {
      print(e.toString());
    }
    for (var i = 0; i < qs.documents.length; i++) {
      if (qs.documents[i].data['class'] == className) {
        documentID = qs.documents[i].documentID;
      }
    }
    Firestore.instance
        .collection('beacons')
        .document(documentID)
        .snapshots()
        .listen((DocumentSnapshot documentSnapshot) {
          var tmp = documentSnapshot.data.keys.toList();
          tmp.remove('id');
          tmp.remove('class');
          studentList.clear();
          tmp.forEach((element) {
            studentList.add({"Name": element});

          });
      setState(() {});
    });
  }

  @override
  void initState() {
    doStuff();
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20, left: 20),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text('Attendance count: ' + studentList.length.toString())),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child:
                  DataTable(
                    columns: <DataColumn>[
                      DataColumn(
                        label: Text(
                          'Name',
                        ),
                      ),
                    ],
                    rows:
                        studentList // Loops through dataColumnText, each iteration assigning the value to element
                            .map(
                              ((element) => DataRow(
                                    cells: <DataCell>[
                                      DataCell(Text(element[
                                          "Name"])), //Extracting from Map element the value
                                    ],
                                  )),
                            )
                            .toList(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: CupertinoButton(
                    child: Text('Next', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SendAttendance()),
                      );
                    },
                    color: Colors.green),
              ),
            ],
          ),
        ));
  }
}
