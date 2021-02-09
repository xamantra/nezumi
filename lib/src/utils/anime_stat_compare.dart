import '../data/index.dart';
import '../data/types/index.dart';

int compareStatMean(OrderBy orderBy, AnimeSummaryStatData a, AnimeSummaryStatData b) {
  switch (orderBy) {
    case OrderBy.ascending:
      return a.mean.compareTo(b.mean);
    case OrderBy.descending:
      return b.mean.compareTo(a.mean);
  }
  return 0;
}

int compareStatEntryCount(OrderBy orderBy, AnimeSummaryStatData a, AnimeSummaryStatData b) {
  switch (orderBy) {
    case OrderBy.ascending:
      return a.entries.length.compareTo(b.entries.length);
    case OrderBy.descending:
      return b.entries.length.compareTo(a.entries.length);
  }
  return 0;
}

int compareStatEpisodesWatched(OrderBy orderBy, AnimeSummaryStatData a, AnimeSummaryStatData b) {
  var a_Eps = a.totalEpisodes;
  var b_Eps = b.totalEpisodes;
  switch (orderBy) {
    case OrderBy.ascending:
      return a_Eps.compareTo(b_Eps);
    case OrderBy.descending:
      return b_Eps.compareTo(a_Eps);
  }
  return 0;
}

int compareStatHoursWatched(OrderBy orderBy, AnimeSummaryStatData a, AnimeSummaryStatData b) {
  var a_Hours = a.totalHours;
  var b_Hours = b.totalHours;
  switch (orderBy) {
    case OrderBy.ascending:
      return a_Hours.compareTo(b_Hours);
    case OrderBy.descending:
      return b_Hours.compareTo(a_Hours);
  }
  return 0;
}
