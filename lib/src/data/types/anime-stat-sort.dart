enum AnimeStatSort {
  mean,
  entryCount,
  episodeCount,
  hoursWatched,
}

String getAnimeStatSortByLabel(AnimeStatSort sortBy) {
  switch (sortBy) {
    case AnimeStatSort.mean:
      return 'Weighted Mean';
    case AnimeStatSort.entryCount:
      return 'Entry Count';
    case AnimeStatSort.episodeCount:
      return 'Episode Watched';
    case AnimeStatSort.hoursWatched:
      return 'Hours Watched';
  }
  return null;
}
