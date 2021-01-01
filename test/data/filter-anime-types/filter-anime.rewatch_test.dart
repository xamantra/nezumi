import 'package:flutter_test/flutter_test.dart';
import 'package:nezumi/src/data/filter-anime-types/filter-anime.rewatch.dart';
import 'package:nezumi/src/data/index.dart';

void main() {
  test(AnimeFilterRewatchType.anyRewatched, () {
    var anime = AnimeData(listStatus: AnimeListStatus(numTimesRewatched: 1));
    var anime2 = AnimeData(listStatus: AnimeListStatus(numTimesRewatched: 0));
    var filter = AnimeFilterRewatchData(type: AnimeFilterRewatchType.anyRewatched);
    var matched = filter.match(anime);
    var matched2 = filter.match(anime2);
    expect(matched, true);
    expect(matched2, false);
  });
  test(AnimeFilterRewatchType.exactCount, () {
    var anime = AnimeData(listStatus: AnimeListStatus(numTimesRewatched: 1));
    var filter = AnimeFilterRewatchData(type: AnimeFilterRewatchType.exactCount, exactCount: 1);
    var filter2 = AnimeFilterRewatchData(type: AnimeFilterRewatchType.exactCount, exactCount: 2);
    var matched = filter.match(anime);
    var matched2 = filter2.match(anime);
    expect(matched, true);
    expect(matched2, false);
  });
  test(AnimeFilterRewatchType.range, () {
    var anime = AnimeData(listStatus: AnimeListStatus(numTimesRewatched: 2));
    var filter = AnimeFilterRewatchData(type: AnimeFilterRewatchType.range, range: [1, 3]);
    var filter2 = AnimeFilterRewatchData(type: AnimeFilterRewatchType.range, range: [4, 6]);
    var matched = filter.match(anime);
    var matched2 = filter2.match(anime);
    expect(matched, true);
    expect(matched2, false);
  });
  test(AnimeFilterRewatchType.lessThan, () {
    var anime = AnimeData(listStatus: AnimeListStatus(numTimesRewatched: 3));
    var filter = AnimeFilterRewatchData(type: AnimeFilterRewatchType.lessThan, lessThan: 4);
    var filter2 = AnimeFilterRewatchData(type: AnimeFilterRewatchType.lessThan, lessThan: 3);
    var matched = filter.match(anime);
    var matched2 = filter2.match(anime);
    expect(matched, true);
    expect(matched2, false);
  });
  test(AnimeFilterRewatchType.moreThan, () {
    var anime = AnimeData(listStatus: AnimeListStatus(numTimesRewatched: 2));
    var filter = AnimeFilterRewatchData(type: AnimeFilterRewatchType.moreThan, moreThan: 1);
    var filter2 = AnimeFilterRewatchData(type: AnimeFilterRewatchType.moreThan, moreThan: 3);
    var matched = filter.match(anime);
    var matched2 = filter2.match(anime);
    expect(matched, true);
    expect(matched2, false);
  });
}
