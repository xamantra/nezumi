import '../../absract/index.dart';
import '../index.dart';

class AnimeFilterGenreData extends AnimeFilterData {
  AnimeFilterGenreData({
    this.includeGenres = const [],
    this.excludeGenres = const [],
  });

  final List<String> includeGenres;
  final List<String> excludeGenres;

  List<String> get includeGenresSorted {
    var list = List<String>.from(includeGenres);
    return list..sort((a, b) => a.compareTo(b));
  }

  List<String> get excludeGenresSorted {
    var list = List<String>.from(excludeGenres);
    return list..sort((a, b) => a.compareTo(b));
  }

  @override
  bool match(AnimeDetails anime) {
    var result = false;
    var checkInclude = includeGenres.isNotEmpty;
    var checkExclude = excludeGenres.isNotEmpty;
    var animeGenres = anime.genres ?? [];
    if (!checkInclude && !checkExclude) {
      return true;
    }
    if (animeGenres.isEmpty) {
      return false;
    }
    var allIncludeGenreMatched = true;
    var allExcludeGenreMatched = false;
    if (checkInclude) {
      allIncludeGenreMatched = includeGenres.every((genre) => animeGenres.any((x) => genre == x.name));
    }
    if (checkExclude) {
      allExcludeGenreMatched = excludeGenres.any((genre) => animeGenres.any((x) => genre == x.name));
    }
    result = allIncludeGenreMatched && !allExcludeGenreMatched;
    return result;
  }

  AnimeFilterGenreData includeGenre(
    String genre, {
    bool remove = false,
  }) {
    var includes = List<String>.from(includeGenres);
    var excludes = List<String>.from(excludeGenres);
    if (remove) {
      includes.removeWhere((x) => x == genre);
    } else {
      excludes.removeWhere((x) => x == genre);
      var exists = includes.any((x) => x == genre);
      if (exists) {
        return this;
      }
      includes.add(genre);
    }
    return copyWith(
      includeGenres: includes,
      excludeGenres: excludes,
    );
  }

  AnimeFilterGenreData excludeGenre(
    String genre, {
    bool remove = false,
  }) {
    var includes = List<String>.from(includeGenres);
    var excludes = List<String>.from(excludeGenres);
    includes.removeWhere((x) => x == genre);
    if (remove) {
      excludes.removeWhere((x) => x == genre);
    } else {
      var exists = excludes.any((x) => x == genre);
      if (exists) {
        return this;
      }
      excludes.add(genre);
    }
    return copyWith(
      includeGenres: includes,
      excludeGenres: excludes,
    );
  }

  AnimeFilterGenreData copyWith({
    List<String> includeGenres,
    List<String> excludeGenres,
  }) {
    return AnimeFilterGenreData(
      includeGenres: includeGenres ?? this.includeGenres,
      excludeGenres: excludeGenres ?? this.excludeGenres,
    );
  }
}
