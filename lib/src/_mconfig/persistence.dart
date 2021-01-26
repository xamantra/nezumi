import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../utils/index.dart';

Box<String> encryptedBox;
Future<void> initStorage() async {
  List<int> bytes = utf8.encode(encryptionKey);

  var appDocDir = await getApplicationDocumentsDirectory();
  var appDocPath = appDocDir.path;

  Hive.init(appDocPath);

  var key = base64Url.decode(base64UrlEncode(bytes));
  encryptedBox = await Hive.openBox<String>('nezumi_box', encryptionCipher: HiveAesCipher(key));
}

Future<bool> persistSave(context, key, value) async {
  try {
    await encryptedBox.put(key, value);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<String> persistGet(context, key) async {
  try {
    var result = encryptedBox.get(key);
    return result;
  } catch (e) {
    print(e);
    return null;
  }
}
