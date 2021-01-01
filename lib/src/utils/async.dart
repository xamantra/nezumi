Future<T> asyncBlock<T>(Future<T> Function() body) async {
  try {
    var result = await body();
    return result;
  } catch (e) {
    print(e);
    return null;
  }
}
