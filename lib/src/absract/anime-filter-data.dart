import 'package:meta/meta.dart';

import '../data/index.dart';

@immutable
abstract class AnimeFilterData {
  bool match(AnimeData animeData);
}
