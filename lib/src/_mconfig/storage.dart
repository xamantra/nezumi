import 'dart:convert';
import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../utils/index.dart';

Box<String> _miscBox;
Box<String> get miscBox => _miscBox;

Box<String> _persistedStateBox;
Box<String> get persistedStateBox => _persistedStateBox;

Box<String> _animeCacheBox;
Box<String> get animeCacheBox => _animeCacheBox;

Box<String> _animeHistoryCacheBox;
Box<String> get animeHistoryCacheBox => _animeHistoryCacheBox;

Future<void> initStorage() async {
  await _initHive(); // not needed in the web, comment out.

  List<int> bytes = utf8.encode(encryptionKey);
  var key = base64Url.decode(base64UrlEncode(bytes));

  _miscBox = await _openBox('misc_box', key);
  _persistedStateBox = await _openBox('nezumi_box', key);
  _animeCacheBox = await _openBox('nezumi_anime_cache_box', key);
  _animeHistoryCacheBox = await _openBox('nezumi_anime_history_cache_box', key);
}

Future<Box<T>> _openBox<T>(String name, Uint8List key) async {
  var box = await Hive.openBox<T>(name, encryptionCipher: HiveAesCipher(key));
  return box;
}

Future<void> _initHive() async {
  var appDocDir = await getApplicationDocumentsDirectory();
  var appDocPath = appDocDir.path;
  Hive.init(appDocPath);
}
