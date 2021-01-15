import 'package:momentum/momentum.dart';

import '../../data/index.dart';
import 'index.dart';

class AnimeSearchModel extends MomentumModel<AnimeSearchController> {
  AnimeSearchModel(
    AnimeSearchController controller, {
    this.query,
    this.results,
    this.loadingResult,
    this.prevPage,
    this.nextPage,
    this.listResults,
  }) : super(controller);

  final String query;

  /// Search results from myanimelist excluding entries that are already in the user's list.
  final List<AnimeDataItem> results;
  final String prevPage;
  final String nextPage;
  final bool loadingResult;

  /// Search results from user's list only.
  final List<AnimeData> listResults;

  @override
  void update({
    String query,
    List<AnimeDataItem> results,
    String prevPage,
    String nextPage,
    bool loadingResult,
    List<AnimeData> listResults,
  }) {
    AnimeSearchModel(
      controller,
      query: query ?? this.query,
      results: results ?? this.results,
      prevPage: prevPage ?? this.prevPage,
      nextPage: nextPage ?? this.nextPage,
      loadingResult: loadingResult ?? this.loadingResult,
      listResults: listResults ?? this.listResults,
    ).updateMomentum();
  }
}
