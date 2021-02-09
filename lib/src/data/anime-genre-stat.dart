import 'package:flutter/material.dart';

import 'index.dart';

class AnimeGenreStatData {
  AnimeGenreStatData({
    @required this.genre,
    @required this.totalHours,
    @required this.weightedMean,
    @required this.totalEpisodes,
    @required this.entries,
  });

  final String genre;
  final double totalHours;
  final double weightedMean;
  final int totalEpisodes;
  final List<AnimeDetails> entries;
}
