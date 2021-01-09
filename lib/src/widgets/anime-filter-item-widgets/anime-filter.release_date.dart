import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../components/anime-filter/index.dart';
import '../../data/filter-anime-types/index.dart';
import '../../mixins/index.dart';
import '../../utils/index.dart';
import '../index.dart';

class AnimeFilterReleaseDateWidget extends StatefulWidget {
  AnimeFilterReleaseDateWidget({Key key}) : super(key: key);

  @override
  _AnimeFilterReleaseDateWidgetState createState() => _AnimeFilterReleaseDateWidgetState();
}

class _AnimeFilterReleaseDateWidgetState extends State<AnimeFilterReleaseDateWidget> with CoreStateMixin {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return MomentumBuilder(
          controllers: [AnimeFilterController],
          builder: (context, snapshot) {
            var filter = animeFilter.getFilter<AnimeFilterReleaseDateData>();
            return Column(
              children: [
                SizedBox(height: sy(8)),
                Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Aired between ',
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
                            var selected = await selectDate(context, filter.finished);
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

  void updateFilter(AnimeFilterReleaseDateData filter, {DateTime start, DateTime finish}) {
    var updated = filter.copyWith(started: start, finished: finish);
    animeFilter.controller.addFilter(updated);
  }
}
