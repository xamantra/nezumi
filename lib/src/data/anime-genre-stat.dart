import 'package:flutter/material.dart';

import 'index.dart';

class AnimeSummaryStatData {
  AnimeSummaryStatData({
    @required this.name,
    @required this.totalHours,
    @required this.mean,
    @required this.totalEpisodes,
    @required this.entries,
  });

  final String name;
  final double totalHours;
  final double mean;
  final int totalEpisodes;
  final List<AnimeDetails> entries;
}
