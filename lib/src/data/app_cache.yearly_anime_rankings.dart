import 'package:meta/meta.dart';

import 'index.dart';

class YearlyAnimeRankingsCache {
  final int year;
  final List<AnimeDetails> allYearEntries;
  final List<AnimeDetails> rankings;

  YearlyAnimeRankingsCache({
    @required this.year,
    @required this.allYearEntries,
    @required this.rankings,
  });
}
