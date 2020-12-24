import 'package:momentum/momentum.dart';

import '../../data/index.dart';
import 'index.dart';

class AnimeFilterModel extends MomentumModel<AnimeFilterController> {
  AnimeFilterModel(
    AnimeFilterController controller, {
    this.results,
  }) : super(controller);

  final List<AnimeData> results;

  @override
  void update({
    List<AnimeData> results,
  }) {
    AnimeFilterModel(
      controller,
      results: results ?? this.results,
    ).updateMomentum();
  }
}
