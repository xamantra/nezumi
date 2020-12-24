T trycatch<T>(T Function() body, [T defaultValue]) {
  try {
    return body();
  } catch (e) {
    return defaultValue;
  }
}
