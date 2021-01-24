String stringReplace(String source, Map<String, String> replace) {
  var result = source;
  replace.forEach((key, value) {
    result = result.replaceAll(key, value);
  });
  return result;
}
