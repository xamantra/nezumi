bool isSameDay(DateTime a, DateTime b) {
  var sameYear = a?.year == b?.year;
  var sameMonth = a?.month == b?.month;
  var sameDay = a?.day == b?.day;
  return sameYear && sameMonth && sameDay;
}
