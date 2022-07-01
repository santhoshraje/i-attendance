<p align="center"><img src="https://github.com/santhoshraje/i-attendance/blob/master/screenshots/logo.png"></p>
<h1></h1>
<h4 align="center">A fast, seamless and contactless classroom attendance taking solution.</br>Created to help with the the current COVID-19 pandemic.</h4>

<p align="center">
<img src="https://img.shields.io/github/release-date/santhoshraje/i-attendance" />
<img src="https://img.shields.io/github/last-commit/santhoshraje/i-attendance/master" />
<img src="https://img.shields.io/badge/license-MIT-orange" />
</p>

<p align="center">
  <a href="#Overview">Overview</a> •
  <a href="#getting-started">Getting Started</a> •
  <a href="#Deployment">Deployment</a> •
  <a href="#Libraries">Libraries</a> •
  <a href="#License">License</a> •
  <a href="#special-thanks">Special Thanks</a> 
</p>

 ## Overview
A cross platform, contact-less attendance tracking system designed to help tertiary education institutions go paperless.
This solution was created to minimise contact between students by removing the need to pass a piece of paper around
the classroom. 

This project is considered complete and is in maintenance mode. This means that we will address critical bugs and security issues but will not add any new features.

<p align="center">
<img src="https://github.com/santhoshraje/i-attendance/blob/master/screenshots/ss_1.png" width="300" height="550">&nbsp;&nbsp;
<img src="https://github.com/santhoshraje/i-attendance/blob/master/screenshots/ss_5.png" width="300" height="550">&nbsp;&nbsp;
<!-- <img src="https://github.com/santhoshraje/i-attendance/blob/master/screenshots/ss_6.png" width="250" height="550">&nbsp; -->
</p>
  
 ## Getting Started

- Create a firebase account and set up your cloud firestore as follows. Create a document under the "pins" collection named "123456". This is the pin lecturers will use in the app to identify themselves as lecturers. Leave the "beacons" collection empty.

<p align="center"><img src="https://github.com/santhoshraje/i-attendance/blob/master/screenshots/ss_2.png"></p>

- Download your config files from firebase and add them to this Flutter project.</br> (demo: https://www.youtube.com/watch?v=DqJ_KjFzL9I)
<p align="center"><img src="https://github.com/santhoshraje/i-attendance/blob/master/screenshots/ss_4.png"></p>

- Update the lines below from lecturer_send_attendance.dart file with your own information. This is to email the attendance report to the recipient.
<p align="center"><img src="https://github.com/santhoshraje/i-attendance/blob/master/screenshots/ss_3.png"></p>


### Prerequisites
 - Flutter
 - Dart
 - Firebase account
 - Cloud firestore database

### Usage
 - Install Flutter
 - Connect your phone to your computer 
 - Run this project from Android Studio or VS Code with Flutter plugin installed

## Deployment
 - Build the application for android and iOS using Flutter and install it to your device.

## Libraries
 - cupertino_icons: ^0.1.3
 - beacon_broadcast: ^0.2.1
 - flutter_beacon: ^0.3.0
 - cloud_firestore: ^0.13.7
 - path_provider: ^1.6.11
 - flutter_blue: ^0.7.2
 - mailer: ^3.0.4
 - csv: ^4.0.3

## License
 - This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Special Thanks




