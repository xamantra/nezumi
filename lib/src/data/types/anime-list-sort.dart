enum AnimeListSortBy {
  title,
  score,
  member,
  userVotes,
  lastUpdated,
  episodesWatched,
  startWatchDate,
  finishWatchDate,
}

String getAnimeListSortByLabel(AnimeListSortBy sortBy) {
  switch (sortBy) {
    case AnimeListSortBy.title:
      return 'Title';
      break;
    case AnimeListSortBy.score:
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
