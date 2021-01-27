import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../utils/index.dart';

Box<String> _persistedStateBox;
Box<String> get persistedStateBox => _persistedStateBox;

Box<String> _animeCacheBox;
Box<String> get animeCacheBox => _animeCacheBox;

Future<void> initStorage() async {
  List<int> bytes = utf8.encode(encryptionKey);

  var appDocDir = await getApplicationDocumentsDirectory();
  var appDocPath = appDocDir.path;

  Hive.init(appDocPath);

  var key = base64Url.decode(base64UrlEncode(bytes));
  _persistedStateBox = await Hive.openBox<String>('nezumi_box', encryptionCipher: HiveAesCipher(key));
  _animeCacheBox = await Hive.openBox<String>('nezumi_anime_cache_box', encryptionCipher: HiveAesCipher(key));
}
