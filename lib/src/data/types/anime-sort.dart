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

String animeSortBy_toJson(AnimeSortBy sortBy) {
  return sortBy.toString();
}

AnimeSortBy animeSortBy_fromJson(String raw) {
  var find = AnimeSortBy.values.firstWhere((x) => x.toString() == raw, orElse: () => null);
  return find;
}
