import 'package:meta/meta.dart';

import '../data/index.dart';

@immutable
abstract class AnimeFilterData {
  bool match(AnimeDetails animeData);
}
