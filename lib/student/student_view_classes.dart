import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:iattendance/attendance_success.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ViewClasses extends StatefulWidget {
  @override
  _ViewClassesState createState() => _ViewClassesState();
}

class _ViewClassesState extends State<ViewClasses> {
  final StreamController<BluetoothState> streamController = StreamController();
  StreamSubscription<BluetoothState> _streamBluetooth;
  StreamSubscription<RangingResult> _streamRanging;
  final _regionBeacons = <Region, List<Beacon>>{};
  final _beacons = <Beacon>[];
  bool authorizationStatusOk = false;
  bool locationServiceEnabled = false;
  bool bluetoothEnabled = false;
  final List<Map<String, String>> classes = [];
  var added = [];
  var documentID = '';

  // file io functions
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/user_name.txt');
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
  void initState() {
    super.initState();
    listeningState();
  }

  listeningState() async {
    print('Listening to bluetooth state');
    _streamBluetooth = flutterBeacon
        .bluetoothStateChanged()
        .listen((BluetoothState state) async {
      print('BluetoothState = $state');
      streamController.add(state);

      switch (state) {
        case BluetoothState.stateOn:
          initScanBeacon();
          break;
        case BluetoothState.stateOff:
          await pauseScanBeacon();
          await checkAllRequirements();
          break;
      }
    });
  }

  checkAllRequirements() async {
    final bluetoothState = await flutterBeacon.bluetoothState;
    final bluetoothEnabled = bluetoothState == BluetoothState.stateOn;
    final authorizationStatus = await flutterBeacon.authorizationStatus;
    final authorizationStatusOk =
        authorizationStatus == AuthorizationStatus.allowed ||
            authorizationStatus == AuthorizationStatus.always;
    final locationServiceEnabled =
        await flutterBeacon.checkLocationServicesIfEnabled;

    setState(() {
      this.authorizationStatusOk = authorizationStatusOk;
      this.locationServiceEnabled = locationServiceEnabled;
      this.bluetoothEnabled = bluetoothEnabled;
    });
  }

  initScanBeacon() async {
    await flutterBeacon.initializeScanning;
    await checkAllRequirements();
    if (!authorizationStatusOk ||
        !locationServiceEnabled ||
        !bluetoothEnabled) {
      print('RETURNED, authorizationStatusOk=$authorizationStatusOk, '
          'locationServiceEnabled=$locationServiceEnabled, '
          'bluetoothEnabled=$bluetoothEnabled');
      return;
    }
    final regions = <Region>[
      Region(
        proximityUUID: 'E2C56DB5-DFFB-48D2-B060-D0F5A71096E0',
      ),
    ];

    if (_streamRanging != null) {
      if (_streamRanging.isPaused) {
        _streamRanging.resume();
        return;
      }
    }

    _streamRanging =
        flutterBeacon.ranging(regions).listen((RangingResult result) {
//      print(result);
      if (result != null && mounted) {
        setState(() {
          _regionBeacons[result.region] = result.beacons;
          _beacons.clear();
          _regionBeacons.values.forEach((list) {
            _beacons.addAll(list);
            // loop thru _beacons
            _beacons.forEach((value) async {
              // extract each beacon's minor
              final minor = value.minor;
              // get class name from firebase
              QuerySnapshot qs;
              try {
                qs = await Firestore.instance
                    .collection('beacons')
                    .getDocuments();
              } catch (e) {
                print(e.toString());
              }
              for (var i = 0; i < qs.documents.length; i++) {
                if (qs.documents[i].data['id'] == minor) {
                  documentID = qs.documents[i].documentID;
                  if (added.contains(minor)) continue;
                  classes.add({"Name": qs.documents[i].data['class']});
                  added.add(minor);
                  setState(() {});
                }
              }
            });
          });
        });
      }
    });
  }

  pauseScanBeacon() async {
    _streamRanging?.pause();
    if (_beacons.isNotEmpty) {
      setState(() {
        _beacons.clear();
      });
    }
  }

  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print('AppLifecycleState = $state');
    if (state == AppLifecycleState.resumed) {
      if (_streamBluetooth != null && _streamBluetooth.isPaused) {
        _streamBluetooth.resume();
      }
      await checkAllRequirements();
      if (authorizationStatusOk && locationServiceEnabled && bluetoothEnabled) {
        await initScanBeacon();
      } else {
        await pauseScanBeacon();
        await checkAllRequirements();
      }
    } else if (state == AppLifecycleState.paused) {
      _streamBluetooth?.pause();
    }
  }

  @override
  void dispose() {
    streamController?.close();
    _streamRanging?.cancel();
    _streamBluetooth?.cancel();
    flutterBeacon.close;
    super.dispose();
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
                    child: Text('Select your class')),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: DataTable(
                    showCheckboxColumn: false,
                    columns: <DataColumn>[
                      DataColumn(
                        label: Text(
                          'Class Name',
                        ),
                      ),
                    ],
                    rows:
                        classes // Loops through dataColumnText, each iteration assigning the value to element
                            .map(
                              ((element) => DataRow(
                                    cells: <DataCell>[
                                      DataCell(Text(element[
                                          "Name"])), //Extracting from Map element the value
                                    ],
                                    onSelectChanged: (bool selected) async {
                                      if (selected) {
                                        String s = element.toString();
                                        s = s.replaceFirst('}', '');
                                        s = s.replaceFirst('{Name: ', '');
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            // return object of type Dialog
                                            return CupertinoAlertDialog(
                                              title: new Text(
                                                  "You are about to submit attendance for " +
                                                      s),
                                              actions: <Widget>[
                                                new FlatButton(
                                                  child: new Text("Cancel"),
                                                  onPressed: () async {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                // usually buttons at the bottom of the dialog
                                                new FlatButton(
                                                  child: new Text("Confirm"),
                                                  onPressed: () async {
                                                    CollectionReference classes = Firestore.instance.collection('beacons');
                                                    final document = classes.document(documentID);
                                                    document.updateData({await readFromDevice(): await readFromDevice()});
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AttendanceSuccess()),
                                                    );
                                                  },
                                                ),

                                              ],
                                            );
                                          },
                                        );
                                      }
                                    },
                                  )),
                            )
                            .toList(),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
