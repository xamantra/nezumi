import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../../data/filter-anime-types/index.dart';
import '../../../../mixins/index.dart';
import '../../../../modules/anime-filter/index.dart';
import '../../../../utils/core.util.dart';
import '../../../index.dart';

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
              margin: EdgeInsets.symmetric(horizontal: sy(8), vertical: sy(4)),
              child: Stack(
                children: [
                  Ripple(
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
                  Align(
                    alignment: Alignment.topRight,
                    child: SizedButton(
                      height: sy(20),
                      width: sy(20),
                      radius: 100,
                      child: Icon(
                        Icons.close,
                        size: sy(14),
                        color: Colors.redAccent,
                      ),
                      onPressed: () {
                        filterWidgetService.removeFilter<GenreFilterWidget>();
                        animeFilter.controller.removeFilter<AnimeGenreFilter>();
                        animeFilter.update(animeGenreFilter: AnimeGenreFilter());
                        app.triggerRebuild();
                      },
                    ),
                  ),
                ],
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
