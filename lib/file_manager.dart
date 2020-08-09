import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileManager {
  // file io functions
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> _localFile(String filePath) async {
    final path = await _localPath;
    return File('$path/' + filePath);
  }

  Future<File> writeToDevice(String s, String filePath) async {
    final file = await _localFile(filePath);
    return file.writeAsString(s);
  }

  Future<String> readFromDevice(String filePath) async {
    try {
      final file = await _localFile(filePath);
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      return 'error';
    }
  }
}
