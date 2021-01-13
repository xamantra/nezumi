enum OrderBy {
  ascending,
  descending,
}

String orderBy_toJson(OrderBy orderBy) {
  return orderBy.toString();
}

OrderBy orderBy_fromJson(String raw) {
  var find = OrderBy.values.firstWhere((x) => x.toString() == raw, orElse: () => null);
  return find;
}
