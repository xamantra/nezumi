import '../../utils/index.dart';

enum AnimeListField {
  title,
  format,
  season,
  airingStatus,
  listStatus,
  episodeCount,
  episodesWatched,
  durationPerEpisode,
  totalDuration,
  sourceMaterial,
  studios,
  ageRating,
}

String animeListField_toJson(AnimeListField field) {
  var index = AnimeListField.values.indexOf(field);
  return animeListFields[index];
}

AnimeListField animeListField_fromJson(String raw) {
  var index = animeListFields.indexOf(raw);
  return AnimeListField.values[index];
}
