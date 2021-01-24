import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../components/anime-filter/index.dart';
import '../../data/filter-anime-types/index.dart';
import '../../mixins/index.dart';
import '../../utils/index.dart';
import '../index.dart';

class AnimeFilterTagsWidget extends StatefulWidget {
  const AnimeFilterTagsWidget({Key key}) : super(key: key);

  @override
  _AnimeFilterTagsWidgetState createState() => _AnimeFilterTagsWidgetState();
}

class _AnimeFilterTagsWidgetState extends State<AnimeFilterTagsWidget> with CoreStateMixin {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return MomentumBuilder(
          controllers: [AnimeFilterController],
          builder: (context, snapshot) {
            var filter = animeFilter.getFilter<AnimeFilterTagsData>();
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
                        items: filter.includeTagsSorted,
                        color: Colors.green,
                        itemCallback: (tag) {
                          updateFilter(true, tag, remove: true);
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
                        chooseTag(filter, true);
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
                        items: filter.excludeTagsSorted,
                        color: Colors.red[800],
                        itemCallback: (tag) {
                          updateFilter(false, tag, remove: true);
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
                        chooseTag(filter, false);
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

  void chooseTag(AnimeFilterTagsData filter, bool include) {
    var widget = Dialog(
      backgroundColor: AppTheme.of(context).primaryBackground,
      child: RelativeBuilder(
        builder: (context, height, width, sy, sx) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: animeFilter.controller
                  .allTag()
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
    String tag, {
    bool remove = false,
  }) {
    var filter = animeFilter.getFilter<AnimeFilterTagsData>();
    if (include) {
      filter = filter.includeTag(tag, remove: remove);
    } else {
      filter = filter.excludeTag(tag, remove: remove);
    }
    animeFilter.controller.addFilter(filter);
  }
}
