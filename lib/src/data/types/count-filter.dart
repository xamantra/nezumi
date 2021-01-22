enum CountFilterType {
  none,
  exactCount,
  range,
  lessThan,
  moreThan,
}

String getCountFilterTypeLabel(CountFilterType type) {
  switch (type) {
    case CountFilterType.none:
      return 'No Filter';
      break;
    case CountFilterType.exactCount:
      return 'Exact Count';
      break;
    case CountFilterType.range:
      return 'Between Range';
      break;
    case CountFilterType.lessThan:
      return 'Less Than';
      break;
    case CountFilterType.moreThan:
      return 'More Than';
      break;
  }
  return 'Any Rewatched';
}
