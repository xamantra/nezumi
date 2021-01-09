import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../data/filter-anime-types/index.dart';
import '../../mixins/index.dart';
import '../../components/anime-filter/index.dart';
import '../../utils/index.dart';
import '../index.dart';

class AnimeFilterGenreWidget extends StatefulWidget {
  const AnimeFilterGenreWidget({Key key}) : super(key: key);

  @override
  _AnimeFilterGenreWidgetState createState() => _AnimeFilterGenreWidgetState();
}

class _AnimeFilterGenreWidgetState extends State<AnimeFilterGenreWidget> with CoreStateMixin {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return MomentumBuilder(
          controllers: [AnimeFilterController],
          builder: (context, snapshot) {
            var filter = animeFilter.getFilter<AnimeFilterGenreData>();
            return Column(
              children: [
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
            );
          },
        );
      },
    );
  }

  void chooseGenre(AnimeFilterGenreData filter, bool include) {
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
    var filter = animeFilter.getFilter<AnimeFilterGenreData>();
    if (include) {
      filter = filter.includeGenre(genre, remove: remove);
    } else {
      filter = filter.excludeGenre(genre, remove: remove);
    }
    animeFilter.controller.addFilter(filter);
  }
}
