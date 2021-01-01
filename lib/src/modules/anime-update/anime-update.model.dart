import 'package:momentum/momentum.dart';

import '../../data/index.dart';
import 'index.dart';

class AnimeUpdateModel extends MomentumModel<AnimeUpdateController> {
  AnimeUpdateModel(
    AnimeUpdateController controller, {
    this.animeData,
    this.currentInput,
    this.loading,
  }) : super(controller);

  final AnimeData animeData;
  final AnimeListStatus currentInput;
  final bool loading;

  @override
  void update({
    AnimeData animeData,
    AnimeListStatus currentInput,
    bool loading,
  }) {
    AnimeUpdateModel(
      controller,
      animeData: animeData ?? this.animeData,
      currentInput: currentInput ?? this.currentInput,
      loading: loading ?? this.loading,
    ).updateMomentum();
  }
}
