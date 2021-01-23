String formatDecimal(double from) {
  try {
    var split = from.toString().split('.');
    var decimal = int.parse(split[1]);
    var result = decimal == 0 ? split[0] : from.toString();
    return result;
  } catch (e) {
    return '0';
  }
}
