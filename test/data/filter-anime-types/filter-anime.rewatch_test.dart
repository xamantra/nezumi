import 'package:flutter_test/flutter_test.dart';
import 'package:nezumi/src/data/filter-anime-types/index.dart';
import 'package:nezumi/src/data/index.dart';
import 'package:nezumi/src/data/types/index.dart';

void main() {
  test(CountFilterType.exactCount, () {
    var anime = AnimeDetails(myListStatus: AnimeListStatus(numTimesRewatched: 1));
    var filter = AnimeFilterRewatchData(type: CountFilterType.exactCount, exactCount: 1);
    var filter2 = AnimeFilterRewatchData(type: CountFilterType.exactCount, exactCount: 2);
    var matched = filter.match(anime);
    var matched2 = filter2.match(anime);
    expect(matched, true);
    expect(matched2, false);
  });
  test(CountFilterType.range, () {
    var anime = AnimeDetails(myListStatus: AnimeListStatus(numTimesRewatched: 2));
    var filter = AnimeFilterRewatchData(type: CountFilterType.range, range: [1, 3]);
    var filter2 = AnimeFilterRewatchData(type: CountFilterType.range, range: [4, 6]);
    var matched = filter.match(anime);
    var matched2 = filter2.match(anime);
    expect(matched, true);
    expect(matched2, false);
  });
  test(CountFilterType.lessThan, () {
    var anime = AnimeDetails(myListStatus: AnimeListStatus(numTimesRewatched: 3));
    var filter = AnimeFilterRewatchData(type: CountFilterType.lessThan, lessThan: 4);
    var filter2 = AnimeFilterRewatchData(type: CountFilterType.lessThan, lessThan: 3);
    var matched = filter.match(anime);
    var matched2 = filter2.match(anime);
    expect(matched, true);
    expect(matched2, false);
  });
  test(CountFilterType.moreThan, () {
    var anime = AnimeDetails(myListStatus: AnimeListStatus(numTimesRewatched: 2));
    var filter = AnimeFilterRewatchData(type: CountFilterType.moreThan, moreThan: 1);
    var filter2 = AnimeFilterRewatchData(type: CountFilterType.moreThan, moreThan: 3);
    var matched = filter.match(anime);
    var matched2 = filter2.match(anime);
    expect(matched, true);
    expect(matched2, false);
  });
}
