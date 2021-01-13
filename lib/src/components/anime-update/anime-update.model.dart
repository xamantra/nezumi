import 'package:momentum/momentum.dart';

import '../../data/index.dart';
import 'index.dart';

class AnimeUpdateModel extends MomentumModel<AnimeUpdateController> {
  AnimeUpdateModel(
    AnimeUpdateController controller, {
    this.id,
    this.title,
    this.animeDetails,
    this.currentInput,
    this.loading,
  }) : super(controller);

  final int id;
  final String title;
  final AnimeDetails animeDetails;
  final AnimeListStatus currentInput;
  final bool loading;

  @override
  void update({
    int id,
    String title,
    AnimeDetails animeDetails,
    AnimeListStatus currentInput,
    bool loading,
  }) {
    AnimeUpdateModel(
      controller,
      id: id ?? this.id,
      title: title ?? this.title,
      animeDetails: animeDetails ?? this.animeDetails,
      currentInput: currentInput ?? this.currentInput,
      loading: loading ?? this.loading,
    ).updateMomentum();
  }
}
