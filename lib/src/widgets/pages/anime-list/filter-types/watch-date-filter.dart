import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../../data/filter-anime-types/index.dart';
import '../../../../mixins/index.dart';
import '../../../../modules/anime-filter/index.dart';
import '../../../index.dart';

class WatchDateFilterWidget extends StatefulWidget {
  WatchDateFilterWidget({Key key}) : super(key: key);

  @override
  _WatchDateFilterWidgetState createState() => _WatchDateFilterWidgetState();
}

class _WatchDateFilterWidgetState extends State<WatchDateFilterWidget> with CoreStateMixin {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return MomentumBuilder(
          controllers: [AnimeFilterController],
          builder: (context, snapshot) {
            var filter = animeFilter.getFilter<AnimeWatchDateFilter>();
            return Row(
              children: [
                Row(
                  children: [
                    Text(
                      'Watched between ',
                      style: TextStyle(
                        fontSize: sy(8),
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    Badge(
                      color: AppTheme.of(context).primary,
                      textColor: Colors.white,
                      text: filter.startFormatted ?? 'select date',
                      fontSize: sy(11),
                      borderRadius: 100,
                      onPressed: (_) async {
                        var now = DateTime.now();
                        var selected = await showDatePicker(
                          context: context,
                          initialDate: filter.started ?? now,
                          firstDate: now.subtract(Duration(days: 100 * 365)),
                          lastDate: now,
                        );
                        updateFilter(filter, start: selected);
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '  and  ',
                      style: TextStyle(
                        fontSize: sy(8),
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    Badge(
                      color: AppTheme.of(context).primary,
                      textColor: Colors.white,
                      text: filter.finishFormatted ?? 'select date',
                      fontSize: sy(11),
                      borderRadius: 100,
                      onPressed: (_) async {
                        var now = DateTime.now();
                        var selected = await showDatePicker(
                          context: context,
                          initialDate: filter.finished ?? now,
                          firstDate: now.subtract(Duration(days: 100 * 365)),
                          lastDate: now,
                        );
                        updateFilter(filter, finish: selected);
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

  void updateFilter(AnimeWatchDateFilter filter, {DateTime start, DateTime finish}) {
    var updated = filter.copyWith(started: start, finished: finish);
    animeFilter.controller.addFilter(updated);
  }
}
