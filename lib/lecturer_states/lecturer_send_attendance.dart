import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:iattendance/shared_states/attendance_success.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:path_provider/path_provider.dart';

class SendAttendance extends StatelessWidget {
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
                          Icons.email,
                          color: Colors.green,
                          size: 100,
                          semanticLabel:
                              'Text to announce in accessibility modes',
                        ),
                        Text('Ready to send your attendance to the office?')
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: CupertinoButton(
                      child:
                          Text('Send', style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        // TODO add your email info here
                        String username = '';
                        String password = '';
                        String recipient = '';

                        final smtpServer = gmail(username, password);

                        final directory =
                            await getApplicationDocumentsDirectory();
                        final filePath = directory.path + "/attendance.csv";
                        File file = File(filePath);

                        // Create our message.
                        final message = Message()
                          ..from = Address(username, 'iAttendance')
                          ..recipients.add(recipient)
                          ..subject = 'Attendance list: ${DateTime.now()}'
                          ..attachments.add(FileAttachment(file))
                          ..text = 'Attendance list for class';

                        try {
                          final sendReport = await send(message, smtpServer);
                          print('Message sent: ' + sendReport.toString());
                        } on MailerException catch (e) {
                          print('Message not sent.');
                          for (var p in e.problems) {
                            print('Problem: ${p.code}: ${p.msg}');
                          }
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AttendanceSuccess()),
                        );
                      },
                      color: Colors.green),
                ),
              ],
            ),
          ),
        ));
  }
}
