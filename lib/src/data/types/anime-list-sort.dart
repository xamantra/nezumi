enum AnimeListSortBy {
  title,
  lastUpdated,
  personalScore,
  episodesWatched,
  startWatchDate,
  finishWatchDate,
  startAirDate,
  endAirDate,
  totalDuration,
  globalScore,
  userVotes,
  member,
}

String getAnimeListSortByLabel(AnimeListSortBy sortBy) {
  switch (sortBy) {
    case AnimeListSortBy.title:
      return 'Title';
    case AnimeListSortBy.globalScore:
      return 'Score';
    case AnimeListSortBy.member:
      return 'Popularity';
    case AnimeListSortBy.userVotes:
      return 'User Votes';
    case AnimeListSortBy.lastUpdated:
      return 'Last Updated';
    case AnimeListSortBy.episodesWatched:
      return 'Episodes Watched';
    case AnimeListSortBy.startWatchDate:
      return 'Start Watch Date';
    case AnimeListSortBy.finishWatchDate:
      return 'Finish Watch Date';
    case AnimeListSortBy.personalScore:
      return 'Personal Score';
    case AnimeListSortBy.totalDuration:
      return 'Total Duration (mins)';
    case AnimeListSortBy.startAirDate:
      return 'Start Air Date';
    case AnimeListSortBy.endAirDate:
      return 'End Air Date';
  }
  return '';
}

String animeListSortBy_toJson(AnimeListSortBy sortBy) {
  return sortBy.toString();
}

AnimeListSortBy animeListSortBy_fromJson(String raw) {
  var find = AnimeListSortBy.values.firstWhere((x) => x.toString() == raw, orElse: () => null);
  return find;
}
