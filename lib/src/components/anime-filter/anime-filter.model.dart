import 'package:momentum/momentum.dart';

import '../../absract/index.dart';
import '../../data/index.dart';
import 'index.dart';

class AnimeFilterModel extends MomentumModel<AnimeFilterController> {
  AnimeFilterModel(
    AnimeFilterController controller, {
    this.animeFilters,
    this.results,
  }) : super(controller);

  final List<AnimeFilterData> animeFilters;
  final List<AnimeDetails> results;

  T getFilter<T extends AnimeFilterData>() {
    try {
      var find = animeFilters.firstWhere((x) => x is T, orElse: () => null);
      return find as T;
    } catch (e) {
      return null;
    }
  }

  bool filterExist<T extends AnimeFilterData>() {
    try {
      var exist = animeFilters.any((x) => x is T);
      return exist;
    } catch (e) {
      return false;
    }
  }

  @override
  void update({
    List<AnimeFilterData> animeFilters,
    List<AnimeDetails> results,
  }) {
    AnimeFilterModel(
      controller,
      animeFilters: animeFilters ?? this.animeFilters,
      results: results ?? this.results,
    ).updateMomentum();
  }
}
