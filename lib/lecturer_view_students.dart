import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:iattendance/lecturer_send_attendance.dart';

class ViewStudents extends StatelessWidget {
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
                child: Align(alignment:Alignment.topLeft,child: Text('Attendance count: 39')),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: DataTable(

                    columns: <DataColumn>[
                      DataColumn(
                        label: Text(
                          'Name',
                        ),
                      ),
                    ],
                    rows: <DataRow>[
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('Sarah')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('Tom')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('Paul')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('Sam')),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('James')),
                        ],
                      ),

                    ],
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
