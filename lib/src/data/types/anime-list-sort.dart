enum AnimeListSortBy {
  title,
  lastUpdated,
  personalScore,
  episodesWatched,
  startWatchDate,
  finishWatchDate,
  totalDuration,
  globalScore,
  userVotes,
  member,
}

String getAnimeListSortByLabel(AnimeListSortBy sortBy) {
  switch (sortBy) {
    case AnimeListSortBy.title:
      return 'Title';
      break;
    case AnimeListSortBy.globalScore:
      return 'Score';
      break;
    case AnimeListSortBy.member:
      return 'Popularity';
      break;
    case AnimeListSortBy.userVotes:
      return 'User Votes';
      break;
    case AnimeListSortBy.lastUpdated:
      return 'Last Updated';
      break;
    case AnimeListSortBy.episodesWatched:
      return 'Episodes Watched';
      break;
    case AnimeListSortBy.startWatchDate:
      return 'Start Watch Date';
      break;
    case AnimeListSortBy.finishWatchDate:
      return 'Finish Watch Date';
      break;
    case AnimeListSortBy.personalScore:
      return 'Personal Score';
      break;
    case AnimeListSortBy.totalDuration:
      return 'Total Duration (mins)';
      break;
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
