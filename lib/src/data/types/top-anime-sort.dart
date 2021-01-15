enum TopAnimeSortBy {
  title,
  score,
  member,
  scoringMember,
  totalDuraton,
}

String getAnimeSortByLabel(TopAnimeSortBy sortBy) {
  switch (sortBy) {
    case TopAnimeSortBy.title:
      return 'Title';
      break;
    case TopAnimeSortBy.score:
      return 'Score';
      break;
    case TopAnimeSortBy.member:
      return 'Popularity';
      break;
    case TopAnimeSortBy.scoringMember:
      return 'Scoring Users';
      break;
    case TopAnimeSortBy.totalDuraton:
      return 'Total Duration (mins)';
      break;
  }
  return '';
}

String animeSortBy_toJson(TopAnimeSortBy sortBy) {
  return sortBy.toString();
}

TopAnimeSortBy animeSortBy_fromJson(String raw) {
  var find = TopAnimeSortBy.values.firstWhere((x) => x.toString() == raw, orElse: () => null);
  return find;
}
