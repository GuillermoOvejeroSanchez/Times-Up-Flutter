import 'dart:collection';
import 'dart:io';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show AssetBundle, rootBundle;
import 'lista.dart';

const int NUM_CARTAS = 40;
ListQueue<String> setLista() {
  //TODO Fetch from Assets String listRaw; readList().then((String value){listRaw = value;});
  List<String> list = listAcademy.split("\n");
  list.shuffle();  
  ListQueue<String> queue = ListQueue<String>();
  for (var i = 0; i < NUM_CARTAS; i++) {
    queue.add(list[i]);
  }
  return queue;
}

/*
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/assets/charList.txt');
}
Future<String> readList() async {
  try {
    final file = await _localFile;

    // Read the file.
    String contents = await file.readAsString();

    return contents;
  } catch (e) {
    // If encountering an error, return 0.
    return "";
  }
}

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/charList.txt');
}
*/