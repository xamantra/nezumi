enum AnimeSortBy {
  title,
  score,
  member,
  scoringMember,
  totalDuraton,
}

String getAnimeSortByLabel(AnimeSortBy sortBy) {
  switch (sortBy) {
    case AnimeSortBy.title:
      return 'Title';
      break;
    case AnimeSortBy.score:
      return 'Score';
      break;
    case AnimeSortBy.member:
      return 'Popularity';
      break;
    case AnimeSortBy.scoringMember:
      return 'Scoring Users';
      break;
    case AnimeSortBy.totalDuraton:
      return 'Total Duration (mins)';
      break;
  }
  return '';
}
