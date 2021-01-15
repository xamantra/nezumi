bool isSameDay(DateTime a, DateTime b) {
  var sameYearMonth = isSameYearMonth(a, b);
  var sameDay = a?.day == b?.day;
  return sameYearMonth && sameDay;
}

bool isSameYearMonth(DateTime a, DateTime b) {
  var sameYear = a?.year == b?.year;
  var sameMonth = a?.month == b?.month;
  return sameYear && sameMonth;
}
