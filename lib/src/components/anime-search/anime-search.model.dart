import 'package:momentum/momentum.dart';

import 'index.dart';

class AnimeSearchModel extends MomentumModel<AnimeSearchController> {
  AnimeSearchModel(
    AnimeSearchController controller, {
    this.query,
  }) : super(controller);

  final String query;

  @override
  void update({
    String query,
  }) {
    AnimeSearchModel(
      controller,
      query: query ?? this.query,
    ).updateMomentum();
  }
}
