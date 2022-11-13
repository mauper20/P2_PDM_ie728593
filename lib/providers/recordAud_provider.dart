import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:record/record.dart';

class RecordAudProvider with ChangeNotifier {
  Future<Map> startRecord() async {
    final record = Record();
    try {
      if (await record.hasPermission()) {
        await record.start();
        print("ando aqui");
      }
      await Future.delayed(Duration(seconds: 4));

      String? _path = await record.stop();
      print(_path);
      if (_path == null) {
        print("No se grabo nada");
        return {};
      }

      File trackFile = File(_path);
      Uint8List fileB = trackFile.readAsBytesSync();
      String base64String = base64Encode(fileB);
      dynamic trackFound = await _MusicInfo(base64String);
      //print("spotify: $trackFound");
      if (trackFound != null) {
        print("no pierde datos!!");
        return trackFound;
      }
    } catch (e) {
      print(e);
    }
    return {};
  }

  Future<dynamic> _MusicInfo(String? _audFile) async {
    final Uri urlAPI = Uri.parse("https://api.audd.io/");
    Map<String, dynamic> urlPram = {
      'api_token': "d61e35d793f85bb6bd3d03e04d9c6701",
      'audio': _audFile,
      'return': 'apple_music,spotify',
    };
    try {
      final answer = await post(urlAPI, body: urlPram);
      if (answer.statusCode == 200) {
        //print(answer.body);
        return (jsonDecode(answer.body)["result"]);
      } else {
        print("Error");
        return null;
      }
    } catch (e) {}
  }
}
