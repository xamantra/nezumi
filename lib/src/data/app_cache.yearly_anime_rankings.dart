import 'package:meta/meta.dart';

import 'index.dart';

class YearlyAnimeRankingsCache {
  final int year;
  final List<AnimeDataItem> allYearEntries;
  final List<AnimeDataItem> rankings;

  YearlyAnimeRankingsCache({
    @required this.year,
    @required this.allYearEntries,
    @required this.rankings,
  });
}
