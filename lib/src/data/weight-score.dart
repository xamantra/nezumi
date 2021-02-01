import 'package:meta/meta.dart';

class ScoreData {
  final double score;
  final double weight;

  double get weighted => score * weight;

  ScoreData({
    @required this.score,
    @required this.weight,
  });
}

class WeightScores {
  final List<ScoreData> scores;

  WeightScores(this.scores);

  double getWeightedMean(int decimalCount) {
    var weightedScoreSum = 0.0;
    var weightSum = 0.0;
    for (var score in scores) {
      weightSum += score.weight;
      weightedScoreSum += score.weighted;
    }

    var result = (weightedScoreSum / weightSum).toStringAsFixed(decimalCount ?? 3);
    return double.parse(result);
  }
}
