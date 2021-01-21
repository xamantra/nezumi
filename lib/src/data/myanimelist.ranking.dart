class Ranking {
  Ranking({
    this.rank,
  });

  final int rank;

  Ranking copyWith({
    int rank,
  }) =>
      Ranking(
        rank: rank ?? this.rank,
      );

  factory Ranking.fromJson(Map<String, dynamic> json) => Ranking(
        rank: json["rank"] == null ? null : json["rank"],
      );

  Map<String, dynamic> toJson() => {
        "rank": rank == null ? null : rank,
      };
}
