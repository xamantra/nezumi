import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../data/filter-anime-types/index.dart';
import '../../mixins/index.dart';
import '../../modules/anime-filter/index.dart';
import '../../utils/index.dart';
import '../index.dart';

class AnimeFilterWatchDateWidget extends StatefulWidget {
  AnimeFilterWatchDateWidget({Key key}) : super(key: key);

  @override
  _AnimeFilterWatchDateWidgetState createState() => _AnimeFilterWatchDateWidgetState();
}

class _AnimeFilterWatchDateWidgetState extends State<AnimeFilterWatchDateWidget> with CoreStateMixin {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return MomentumBuilder(
          controllers: [AnimeFilterController],
          builder: (context, snapshot) {
            var filter = animeFilter.getFilter<AnimeFilterWatchDateData>();
            return Column(
              children: [
                SizedBox(height: sy(8)),
                Row(
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
                            var selected = await selectDate(context, filter.started);
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
                ),
              ],
            );
          },
        );
      },
    );
  }

  void updateFilter(AnimeFilterWatchDateData filter, {DateTime start, DateTime finish}) {
    var updated = filter.copyWith(started: start, finished: finish);
    animeFilter.controller.addFilter(updated);
  }
}
