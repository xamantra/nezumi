import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../data/filter-anime-types/index.dart';
import '../../mixins/index.dart';
import '../../components/anime-filter/index.dart';
import '../../utils/index.dart';
import '../app-theme.dart';
import '../index.dart';

class AnimeFilterRewatchWidget extends StatefulWidget {
  const AnimeFilterRewatchWidget({Key key}) : super(key: key);

  @override
  _AnimeFilterRewatchWidgetState createState() => _AnimeFilterRewatchWidgetState();
}

class _AnimeFilterRewatchWidgetState extends State<AnimeFilterRewatchWidget> with CoreStateMixin {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return MomentumBuilder(
          controllers: [AnimeFilterController],
          builder: (context, snapshot) {
            var filter = animeFilter.getFilter<AnimeFilterRewatchData>();
            return Column(
              children: [
                SizedBox(height: sy(4)),
                Row(
                  children: [
                    PopupMenuButton<AnimeFilterRewatchType>(
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
                        return AnimeFilterRewatchType.values
                            .map(
                              (type) => PopupMenuItem<AnimeFilterRewatchType>(
                                value: type,
                                child: Text(
                                  getRewatchFilterTypeLabel(type),
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

  Widget buildTypeWidget(AnimeFilterRewatchData filter) {
    var type = filter.type;
    var borderSide = BorderSide(color: AppTheme.of(context).accent, width: 2);
    var underlineInputBorder = UnderlineInputBorder(borderSide: borderSide);

    var exactCount = filter.exactCount ?? 0;
    var rangeMin = trycatch(() => filter.range[0] ?? 0, 0);
    var rangeMax = trycatch(() => filter.range[1] ?? 0, 0);
    var lessThan = filter.lessThan ?? 0;
    var moreThan = filter.moreThan ?? 0;

    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        switch (type) {
          case AnimeFilterRewatchType.none:
            return SizedBox();
            break;
          case AnimeFilterRewatchType.anyRewatched:
            return SizedBox();
            break;
          case AnimeFilterRewatchType.exactCount:
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sy(6)),
                  child: Dot(color: AppTheme.of(context).text3),
                ),
                Text(
                  'Rewatched ',
                  style: TextStyle(
                    fontSize: sy(10),
                    color: AppTheme.of(context).text3,
                  ),
                ),
                SizedBox(
                  height: sy(12),
                  width: sy(18),
                  child: TextFormField(
                    initialValue: exactCount == 0 ? '' : exactCount?.toString(),
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    key: Key(AnimeFilterRewatchType.exactCount.toString()),
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
                      var updated = filter.copyWith(exactCount: exactCount);
                      updateFilter(updated);
                    },
                  ),
                ),
                Text(
                  exactCount <= 1 ? ' time' : ' times',
                  style: TextStyle(
                    fontSize: sy(10),
                    color: AppTheme.of(context).text3,
                  ),
                ),
              ],
            );
            break;
          case AnimeFilterRewatchType.range:
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sy(6)),
                  child: Dot(color: AppTheme.of(context).text3),
                ),
                Text(
                  'Rewatched ',
                  style: TextStyle(
                    fontSize: sy(10),
                    color: AppTheme.of(context).text3,
                  ),
                ),
                SizedBox(
                  height: sy(12),
                  width: sy(18),
                  child: TextFormField(
                    initialValue: rangeMin == 0 ? '' : rangeMin?.toString(),
                    maxLines: 1,
                    key: Key('AnimeFilterRewatchType.range[0]'),
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
                    initialValue: rangeMax == 0 ? '' : rangeMax?.toString(),
                    maxLines: 1,
                    key: Key('AnimeFilterRewatchType.range[1]'),
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
                      var updated = filter.copyWith(range: [rangeMin, rangeMax]);
                      updateFilter(updated);
                    },
                  ),
                ),
                Text(
                  rangeMax <= 1 ? ' time' : ' times',
                  style: TextStyle(
                    fontSize: sy(10),
                    color: AppTheme.of(context).text3,
                  ),
                ),
              ],
            );
            break;
          case AnimeFilterRewatchType.lessThan:
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sy(6)),
                  child: Dot(color: AppTheme.of(context).text3),
                ),
                Text(
                  'Rewatched less than ',
                  style: TextStyle(
                    fontSize: sy(10),
                    color: AppTheme.of(context).text3,
                  ),
                ),
                SizedBox(
                  height: sy(12),
                  width: sy(18),
                  child: TextFormField(
                    initialValue: lessThan == 0 ? '' : lessThan?.toString(),
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    key: Key(AnimeFilterRewatchType.lessThan.toString()),
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
                      var updated = filter.copyWith(lessThan: lessThan);
                      updateFilter(updated);
                    },
                  ),
                ),
                Text(
                  lessThan <= 1 ? ' time' : ' times',
                  style: TextStyle(
                    fontSize: sy(10),
                    color: AppTheme.of(context).text3,
                  ),
                ),
              ],
            );
            break;
          case AnimeFilterRewatchType.moreThan:
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sy(6)),
                  child: Dot(color: AppTheme.of(context).text3),
                ),
                Text(
                  'Rewatched more than ',
                  style: TextStyle(
                    fontSize: sy(10),
                    color: AppTheme.of(context).text3,
                  ),
                ),
                SizedBox(
                  height: sy(12),
                  width: sy(18),
                  child: TextFormField(
                    initialValue: moreThan == 0 ? '' : moreThan?.toString(),
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    key: Key(AnimeFilterRewatchType.moreThan.toString()),
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
                      var updated = filter.copyWith(moreThan: moreThan);
                      updateFilter(updated);
                    },
                  ),
                ),
                Text(
                  moreThan <= 1 ? ' time' : ' times',
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

  void updateFilter(AnimeFilterRewatchData filter) {
    animeFilter.controller.addFilter(filter);
  }
}
