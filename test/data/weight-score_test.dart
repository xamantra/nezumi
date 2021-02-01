import 'package:flutter_test/flutter_test.dart';
import 'package:nezumi/src/data/index.dart';

void main() {
  test('WeightScores', () {
    // weight = number of user votes.
    var source = WeightScores([
      ScoreData(score: 8, weight: 124245),
      ScoreData(score: 7, weight: 20014),
      ScoreData(score: 7, weight: 78745),
      ScoreData(score: 7, weight: 325585),
      ScoreData(score: 9, weight: 242475),
    ]);
    // 7.77009572

    var weightedMean2 = source.getWeightedMean(2);
    var weightedMean3 = source.getWeightedMean(3);
    var weightedMean4 = source.getWeightedMean(4);
    expect(weightedMean2, 7.77);
    expect(weightedMean3, 7.770);
    expect(weightedMean4, 7.7701);
  });
}
