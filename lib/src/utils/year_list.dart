final yearList = <int>[];

void InitializeYearList() {
  const initialYear = 1900;
  final lastYearNumber = DateTime.now().year + 3;
  for (var i = initialYear; i >= initialYear && i <= lastYearNumber; i++) {
    yearList.add(i);
  }
  yearList.sort((a, b) => b.compareTo(a));
  return;
}
