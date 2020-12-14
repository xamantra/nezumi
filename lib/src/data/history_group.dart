import 'package:flutter/foundation.dart';

import 'index.dart';

class HistoryGroupData {
  final String day;
  final List<AnimeHistory> historyList;

  HistoryGroupData({
    @required this.day,
    @required this.historyList,
  });
}
