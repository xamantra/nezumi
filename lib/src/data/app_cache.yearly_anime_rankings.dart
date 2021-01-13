import 'package:meta/meta.dart';

import 'index.dart';

class YearlyAnimeRankingsCache {
  final int year;
  final List<AnimeDataItem> rankings;

  YearlyAnimeRankingsCache({
    @required this.year,
    @required this.rankings,
  });

  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'rankings': rankings?.map((x) => x?.toJson())?.toList(),
    };
  }

  factory YearlyAnimeRankingsCache.fromJson(Map<String, dynamic> map) {
    if (map == null) return null;

    return YearlyAnimeRankingsCache(
      year: map['year'],
      rankings: List<AnimeDataItem>.from(map['rankings']?.map((x) => AnimeDataItem.fromJson(x))),
    );
  }
}
