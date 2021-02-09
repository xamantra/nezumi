import 'package:flutter/material.dart';

import 'index.dart';

class AnimeGenreStatData {
  AnimeGenreStatData({
    @required this.genre,
    @required this.totalHours,
    @required this.mean,
    @required this.totalEpisodes,
    @required this.entries,
  });

  final String genre;
  final double totalHours;
  final double mean;
  final int totalEpisodes;
  final List<AnimeDetails> entries;
}
