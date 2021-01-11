import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = new FlutterSecureStorage();

Future<bool> persistSave(context, key, value) async {
  try {
    await storage.write(key: key, value: value);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<String> persistGet(context, key) async {
  try {
    var result = await storage.read(key: key);
    return result;
  } catch (e) {
    print(e);
    return null;
  }
}
