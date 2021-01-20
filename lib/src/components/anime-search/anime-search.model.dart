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
    this.currentPage,
    this.listResults,
  }) : super(controller);

  final String query;

  /// Search results from myanimelist excluding entries that are already in the user's list.
  final List<AnimeDetails> results;
  final String prevPage;
  final String nextPage;
  final bool loadingResult;
  final int currentPage;

  /// Search results from user's list only.
  final List<AnimeDetails> listResults;

  @override
  void update({
    String query,
    List<AnimeDetails> results,
    String prevPage,
    String nextPage,
    bool loadingResult,
    int currentPage,
    List<AnimeDetails> listResults,
  }) {
    AnimeSearchModel(
      controller,
      query: query ?? this.query,
      results: results ?? this.results,
      prevPage: prevPage ?? this.prevPage,
      nextPage: nextPage ?? this.nextPage,
      loadingResult: loadingResult ?? this.loadingResult,
      currentPage: currentPage ?? this.currentPage,
      listResults: listResults ?? this.listResults,
    ).updateMomentum();
  }
}
