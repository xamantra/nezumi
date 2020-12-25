import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../../absract/index.dart';
import '../../../../data/index.dart';
import '../../../../mixins/index.dart';
import '../../../../modules/anime-filter/index.dart';
import '../../../../utils/core.util.dart';
import '../../../index.dart';

class AnimeGenreFilter extends AnimeFilterBase {
  AnimeGenreFilter({
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
  bool match(AnimeData anime) {
    var result = false;
    var checkInclude = includeGenres.isNotEmpty;
    var checkExclude = excludeGenres.isNotEmpty;
    var animeGenres = anime.node.genres ?? [];
    if (!checkInclude && !checkExclude) {
      return false;
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

  AnimeGenreFilter includeGenre(
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

  AnimeGenreFilter excludeGenre(
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

  AnimeGenreFilter copyWith({
    List<String> includeGenres,
    List<String> excludeGenres,
  }) {
    return AnimeGenreFilter(
      includeGenres: includeGenres ?? this.includeGenres,
      excludeGenres: excludeGenres ?? this.excludeGenres,
    );
  }
}

class GenreFilterWidget extends StatefulWidget {
  const GenreFilterWidget({Key key}) : super(key: key);

  @override
  _GenreFilterWidgetState createState() => _GenreFilterWidgetState();
}

class _GenreFilterWidgetState extends State<GenreFilterWidget> with CoreStateMixin {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return MomentumBuilder(
          controllers: [AnimeFilterController],
          builder: (context, snapshot) {
            var filter = animeFilter.animeGenreFilter;
            return Card(
              color: AppTheme.of(context).secondaryBackground,
              margin: EdgeInsets.all(sy(8)),
              child: Ripple(
                child: Container(
                  width: width,
                  padding: EdgeInsets.all(sy(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Genre Filter',
                        style: TextStyle(
                          color: AppTheme.of(context).text2,
                          fontSize: sy(10),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Include: ',
                            style: TextStyle(
                              fontSize: sy(8),
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                          Expanded(
                            child: HorizontalBadgeList(
                              items: filter.includeGenresSorted,
                              color: Colors.green,
                              itemCallback: (genre) {
                                updateFilter(true, genre, remove: true);
                              },
                            ),
                          ),
                          SizedButton(
                            height: sy(25),
                            width: sy(25),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              chooseGenre(filter, true);
                            },
                          ),
                        ],
                      ),
                      Divider(height: 1, color: Colors.white.withOpacity(0.3)),
                      Row(
                        children: [
                          Text(
                            'Exclude: ',
                            style: TextStyle(
                              fontSize: sy(8),
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                          Expanded(
                            child: HorizontalBadgeList(
                              items: filter.excludeGenresSorted,
                              color: Colors.red[800],
                              itemCallback: (genre) {
                                updateFilter(false, genre, remove: true);
                              },
                            ),
                          ),
                          SizedButton(
                            height: sy(25),
                            width: sy(25),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              chooseGenre(filter, false);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void chooseGenre(AnimeGenreFilter filter, bool include) {
    var widget = Dialog(
      backgroundColor: AppTheme.of(context).primaryBackground,
      child: RelativeBuilder(
        builder: (context, height, width, sy, sx) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: animeFilter.controller
                  .allGenre()
                  .map(
                    (x) => Ripple(
                      child: Container(
                        height: sy(36),
                        width: width,
                        padding: EdgeInsets.all(sy(8)),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            x,
                            style: TextStyle(
                              fontSize: sy(10),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        updateFilter(include, x);
                        Navigator.pop(context);
                      },
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
    dialog(context, widget);
  }

  void updateFilter(
    bool include,
    String genre, {
    bool remove = false,
  }) {
    var filter = animeFilter.animeGenreFilter;
    if (include) {
      filter = filter.includeGenre(genre, remove: remove);
    } else {
      filter = filter.excludeGenre(genre, remove: remove);
    }
    animeFilter.update(animeGenreFilter: filter);
    animeFilter.controller.addFilter(filter);
  }
}
