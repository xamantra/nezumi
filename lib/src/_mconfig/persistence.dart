import 'index.dart';

Future<bool> persistSave(context, key, value) async {
  try {
    await persistedStateBox.put(key, value);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<String> persistGet(context, key) async {
  try {
    var result = persistedStateBox.get(key);
    return result;
  } catch (e) {
    print(e);
    return null;
  }
}
