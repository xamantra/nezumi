import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../components/anime-filter/index.dart';
import '../../data/filter-anime-types/index.dart';
import '../../data/types/index.dart';
import '../../mixins/index.dart';
import '../../utils/index.dart';
import '../app-theme.dart';
import '../index.dart';

class AnimeFilterEpisodesWidget extends StatefulWidget {
  const AnimeFilterEpisodesWidget({Key key}) : super(key: key);

  @override
  _AnimeFilterEpisodesWidgetState createState() => _AnimeFilterEpisodesWidgetState();
}

class _AnimeFilterEpisodesWidgetState extends State<AnimeFilterEpisodesWidget> with CoreStateMixin {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return MomentumBuilder(
          controllers: [AnimeFilterController],
          builder: (context, snapshot) {
            var filter = animeFilter.getFilter<AnimeFilterEpisodesData>();
            return Column(
              children: [
                SizedBox(height: sy(4)),
                Row(
                  children: [
                    PopupMenuButton<CountFilterType>(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: sy(8)),
                        child: Text(
                          filter.label,
                          style: TextStyle(
                            color: AppTheme.of(context).accent,
                            fontSize: sy(9),
                          ),
                        ),
                      ),
                      onSelected: (value) {
                        var updated = filter.copyWith(type: value);
                        updateFilter(updated);
                      },
                      itemBuilder: (context) {
                        return CountFilterType.values
                            .map(
                              (type) => PopupMenuItem<CountFilterType>(
                                value: type,
                                child: Text(
                                  getCountFilterTypeLabel(type),
                                  style: TextStyle(
                                    color: AppTheme.of(context).accent,
                                    fontSize: sy(9),
                                  ),
                                ),
                              ),
                            )
                            .toList();
                      },
                    ),
                    buildTypeWidget(filter),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget buildTypeWidget(AnimeFilterEpisodesData filter) {
    var type = filter.type;
    var borderSide = BorderSide(color: AppTheme.of(context).accent, width: 2);
    var underlineInputBorder = UnderlineInputBorder(borderSide: borderSide);

    var exactCount = filter.exactCount ?? -1;
    var rangeMin = trycatch(() => filter.range[0] ?? -1, -1);
    var rangeMax = trycatch(() => filter.range[1] ?? -1, -1);
    var lessThan = filter.lessThan ?? -1;
    var moreThan = filter.moreThan ?? 999999;

    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        switch (type) {
          case CountFilterType.none:
            return SizedBox();
            break;
          case CountFilterType.exactCount:
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sy(6)),
                  child: Dot(color: AppTheme.of(context).text3),
                ),
                Text(
                  'Has ',
                  style: TextStyle(
                    fontSize: sy(10),
                    color: AppTheme.of(context).text3,
                  ),
                ),
                SizedBox(
                  height: sy(12),
                  width: sy(18),
                  child: TextFormField(
                    initialValue: exactCount <= 0 ? '' : exactCount?.toString(),
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    key: Key(CountFilterType.exactCount.toString()),
                    decoration: InputDecoration(
                      border: underlineInputBorder,
                      enabledBorder: underlineInputBorder,
                      focusedBorder: underlineInputBorder,
                      isDense: true,
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppTheme.of(context).accent,
                      fontSize: sy(10),
                    ),
                    onChanged: (value) {
                      var exactCount = trycatch(() => int.parse(value), 0);
                      if (value == null || value.isEmpty) {
                        exactCount = -1;
                      }
                      var updated = filter.copyWith(exactCount: exactCount);
                      updateFilter(updated);
                    },
                  ),
                ),
                Text(
                  exactCount <= 1 ? ' episode' : ' episodes',
                  style: TextStyle(
                    fontSize: sy(10),
                    color: AppTheme.of(context).text3,
                  ),
                ),
              ],
            );
            break;
          case CountFilterType.range:
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sy(6)),
                  child: Dot(color: AppTheme.of(context).text3),
                ),
                Text(
                  'Has ',
                  style: TextStyle(
                    fontSize: sy(10),
                    color: AppTheme.of(context).text3,
                  ),
                ),
                SizedBox(
                  height: sy(12),
                  width: sy(18),
                  child: TextFormField(
                    initialValue: rangeMin <= 0 ? '' : rangeMin?.toString(),
                    maxLines: 1,
                    key: Key('CountFilterType.range[0]'),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: underlineInputBorder,
                      enabledBorder: underlineInputBorder,
                      focusedBorder: underlineInputBorder,
                      isDense: true,
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppTheme.of(context).accent,
                      fontSize: sy(10),
                    ),
                    onChanged: (value) {
                      var rangeMin = trycatch(() => int.parse(value), 0);
                      if (value == null || value.isEmpty) {
                        rangeMin = -1;
                      }
                      var updated = filter.copyWith(range: [rangeMin, rangeMax]);
                      updateFilter(updated);
                    },
                  ),
                ),
                Text(
                  ' to ',
                  style: TextStyle(
                    fontSize: sy(10),
                    color: AppTheme.of(context).text3,
                  ),
                ),
                SizedBox(
                  height: sy(12),
                  width: sy(18),
                  child: TextFormField(
                    initialValue: rangeMax <= 0 ? '' : rangeMax?.toString(),
                    maxLines: 1,
                    key: Key('CountFilterType.range[1]'),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: underlineInputBorder,
                      enabledBorder: underlineInputBorder,
                      focusedBorder: underlineInputBorder,
                      isDense: true,
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppTheme.of(context).accent,
                      fontSize: sy(10),
                    ),
                    onChanged: (value) {
                      var rangeMax = trycatch(() => int.parse(value), 0);
                      if (value == null || value.isEmpty) {
                        rangeMax = -1;
                      }
                      var updated = filter.copyWith(range: [rangeMin, rangeMax]);
                      updateFilter(updated);
                    },
                  ),
                ),
                Text(
                  rangeMax <= 1 ? ' episode' : ' episodes',
                  style: TextStyle(
                    fontSize: sy(10),
                    color: AppTheme.of(context).text3,
                  ),
                ),
              ],
            );
            break;
          case CountFilterType.lessThan:
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sy(6)),
                  child: Dot(color: AppTheme.of(context).text3),
                ),
                Text(
                  'Has less than ',
                  style: TextStyle(
                    fontSize: sy(10),
                    color: AppTheme.of(context).text3,
                  ),
                ),
                SizedBox(
                  height: sy(12),
                  width: sy(18),
                  child: TextFormField(
                    initialValue: lessThan <= 0 ? '' : lessThan?.toString(),
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    key: Key(CountFilterType.lessThan.toString()),
                    decoration: InputDecoration(
                      border: underlineInputBorder,
                      enabledBorder: underlineInputBorder,
                      focusedBorder: underlineInputBorder,
                      isDense: true,
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppTheme.of(context).accent,
                      fontSize: sy(10),
                    ),
                    onChanged: (value) {
                      var lessThan = trycatch(() => int.parse(value), 0);
                      if (value == null || value.isEmpty) {
                        lessThan = -1;
                      }
                      var updated = filter.copyWith(lessThan: lessThan);
                      updateFilter(updated);
                    },
                  ),
                ),
                Text(
                  lessThan <= 1 ? ' episode' : ' episodes',
                  style: TextStyle(
                    fontSize: sy(10),
                    color: AppTheme.of(context).text3,
                  ),
                ),
              ],
            );
            break;
          case CountFilterType.moreThan:
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sy(6)),
                  child: Dot(color: AppTheme.of(context).text3),
                ),
                Text(
                  'Has more than ',
                  style: TextStyle(
                    fontSize: sy(10),
                    color: AppTheme.of(context).text3,
                  ),
                ),
                SizedBox(
                  height: sy(12),
                  width: sy(18),
                  child: TextFormField(
                    initialValue: moreThan >= 999999 ? '' : moreThan?.toString(),
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    key: Key(CountFilterType.moreThan.toString()),
                    decoration: InputDecoration(
                      border: underlineInputBorder,
                      enabledBorder: underlineInputBorder,
                      focusedBorder: underlineInputBorder,
                      isDense: true,
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppTheme.of(context).accent,
                      fontSize: sy(10),
                    ),
                    onChanged: (value) {
                      var moreThan = trycatch(() => int.parse(value), 0);
                      if (value == null || value.isEmpty) {
                        moreThan = 999999;
                      }
                      var updated = filter.copyWith(moreThan: moreThan);
                      updateFilter(updated);
                    },
                  ),
                ),
                Text(
                  moreThan <= 1 ? ' episode' : ' episodes',
                  style: TextStyle(
                    fontSize: sy(10),
                    color: AppTheme.of(context).text3,
                  ),
                ),
              ],
            );
            break;
        }
        return SizedBox();
      },
    );
  }

  void updateFilter(AnimeFilterEpisodesData filter) {
    animeFilter.controller.addFilter(filter);
  }
}
