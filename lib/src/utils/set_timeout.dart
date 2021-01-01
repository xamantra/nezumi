void setTimeout(void Function() body, int timeout) async {
  try {
    await Future.delayed(Duration(milliseconds: timeout));
    await body();
    return;
  } catch (e) {
    print(e);
    return;
  }
}
