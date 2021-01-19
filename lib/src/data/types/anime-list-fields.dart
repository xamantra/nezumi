import '../../utils/index.dart';

enum AnimeListField {
  title,
  format,
  season,
  airingStatus,
  listStatus,
  episodes,
  durationPerEpisode,
  totalDuration,
  sourceMaterial,
  studios,
  ageRating,
}

String animeListField_toJson(AnimeListField field) {
  try {
    var index = AnimeListField.values.indexOf(field);
    return animeListFields[index];
  } catch (e) {
    return '';
  }
}

AnimeListField animeListField_fromJson(String raw) {
  try {
    var index = animeListFields.indexOf(raw);
    return AnimeListField.values[index];
  } catch (e) {
    return AnimeListField.title;
  }
}
