import '../../absract/index.dart';
import '../index.dart';

class AnimeFilterTagsData extends AnimeFilterData {
  AnimeFilterTagsData({
    this.includeTags = const [],
    this.excludeTags = const [],
  });

  final List<String> includeTags;
  final List<String> excludeTags;

  List<String> get includeTagsSorted {
    var list = List<String>.from(includeTags);
    return list..sort((a, b) => a.compareTo(b));
  }

  List<String> get excludeTagsSorted {
    var list = List<String>.from(excludeTags);
    return list..sort((a, b) => a.compareTo(b));
  }

  @override
  bool match(AnimeDetails anime) {
    var result = false;
    var checkInclude = includeTags.isNotEmpty;
    var checkExclude = excludeTags.isNotEmpty;
    var animeTags = anime?.myListStatus?.tags ?? [];
    if (!checkInclude && !checkExclude) {
      return true;
    }
    if (animeTags.isEmpty) {
      return false;
    }
    var allIncludeTagMatched = true;
    var allExcludeTagMatched = false;
    if (checkInclude) {
      allIncludeTagMatched = includeTags.every((tag) => animeTags.any((x) => tag == x));
    }
    if (checkExclude) {
      allExcludeTagMatched = excludeTags.any((tag) => animeTags.any((x) => tag == x));
    }
    result = allIncludeTagMatched && !allExcludeTagMatched;
    return result;
  }

  AnimeFilterTagsData includeTag(
    String tag, {
    bool remove = false,
  }) {
    var includes = List<String>.from(includeTags);
    var excludes = List<String>.from(excludeTags);
    if (remove) {
      includes.removeWhere((x) => x == tag);
    } else {
      excludes.removeWhere((x) => x == tag);
      var exists = includes.any((x) => x == tag);
      if (exists) {
        return this;
      }
      includes.add(tag);
    }
    return copyWith(
      includeTags: includes,
      excludeTags: excludes,
    );
  }

  AnimeFilterTagsData excludeTag(
    String tag, {
    bool remove = false,
  }) {
    var includes = List<String>.from(includeTags);
    var excludes = List<String>.from(excludeTags);
    includes.removeWhere((x) => x == tag);
    if (remove) {
      excludes.removeWhere((x) => x == tag);
    } else {
      var exists = excludes.any((x) => x == tag);
      if (exists) {
        return this;
      }
      excludes.add(tag);
    }
    return copyWith(
      includeTags: includes,
      excludeTags: excludes,
    );
  }

  AnimeFilterTagsData copyWith({
    List<String> includeTags,
    List<String> excludeTags,
  }) {
    return AnimeFilterTagsData(
      includeTags: includeTags ?? this.includeTags,
      excludeTags: excludeTags ?? this.excludeTags,
    );
  }
}
