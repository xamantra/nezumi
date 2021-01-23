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

class AnimeFilterDurationPerEpWidget extends StatefulWidget {
  const AnimeFilterDurationPerEpWidget({Key key}) : super(key: key);

  @override
  _AnimeFilterDurationPerEpWidgetState createState() => _AnimeFilterDurationPerEpWidgetState();
}

class _AnimeFilterDurationPerEpWidgetState extends State<AnimeFilterDurationPerEpWidget> with CoreStateMixin {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return MomentumBuilder(
          controllers: [AnimeFilterController],
          builder: (context, snapshot) {
            var filter = animeFilter.getFilter<AnimeFilterDurationPerEpData>();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: sy(4)),
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
                filter.type == CountFilterType.none
                    ? SizedBox()
                    : Row(
                        children: [
                          buildTypeWidget(filter),
                          PopupMenuButton<DurationType>(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: sy(8)),
                              child: Row(
                                children: [
                                  Text(
                                    ' ${filter.durationLabel} ',
                                    style: TextStyle(
                                      color: AppTheme.of(context).secondary,
                                      fontSize: sy(10),
                                    ),
                                  ),
                                  Text(
                                    'per episode',
                                    style: TextStyle(
                                      color: AppTheme.of(context).text3,
                                      fontSize: sy(10),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onSelected: (value) {
                              var updated = filter.copyWith(durationType: value);
                              updateFilter(updated);
                            },
                            itemBuilder: (context) {
                              return DurationType.values
                                  .map(
                                    (type) => PopupMenuItem<DurationType>(
                                      value: type,
                                      child: Text(
                                        getDurationTypeLabel(type),
                                        style: TextStyle(
                                          color: AppTheme.of(context).secondary,
                                          fontSize: sy(10),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList();
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

  Widget buildTypeWidget(AnimeFilterDurationPerEpData filter) {
    var type = filter.type;
    var borderSide = BorderSide(color: AppTheme.of(context).accent, width: 2);
    var underlineInputBorder = UnderlineInputBorder(borderSide: borderSide);

    var exactCount = filter.exactCount ?? -1.0;
    var rangeMin = trycatch(() => filter.range[0] ?? -1.0, -1.0);
    var rangeMax = trycatch(() => filter.range[1] ?? -1.0, -1.0);
    var lessThan = filter.lessThan ?? -1.0;
    var moreThan = filter.moreThan ?? 999999.0;

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
                Text(
                  'Exactly ',
                  style: TextStyle(
                    fontSize: sy(10),
                    color: AppTheme.of(context).text3,
                  ),
                ),
                SizedBox(
                  height: sy(12),
                  width: sy(18),
                  child: TextFormField(
                    initialValue: exactCount <= 0 ? '' : formatDecimal(exactCount),
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
                      var exactCount = trycatch(() => double.parse(value), 0.0);
                      if (value == null || value.isEmpty) {
                        exactCount = -1;
                      }
                      var updated = filter.copyWith(exactCount: exactCount);
                      updateFilter(updated);
                    },
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
                Text(
                  'From ',
                  style: TextStyle(
                    fontSize: sy(10),
                    color: AppTheme.of(context).text3,
                  ),
                ),
                SizedBox(
                  height: sy(12),
                  width: sy(18),
                  child: TextFormField(
                    initialValue: rangeMin <= 0 ? '' : formatDecimal(rangeMin),
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
                      var rangeMin = trycatch(() => double.parse(value), 0.0);
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
                    initialValue: rangeMax <= 0 ? '' : formatDecimal(rangeMax),
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
                      var rangeMax = trycatch(() => double.parse(value), 0.0);
                      if (value == null || value.isEmpty) {
                        rangeMax = -1;
                      }
                      var updated = filter.copyWith(range: [rangeMin, rangeMax]);
                      updateFilter(updated);
                    },
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
                Text(
                  'Is less than ',
                  style: TextStyle(
                    fontSize: sy(10),
                    color: AppTheme.of(context).text3,
                  ),
                ),
                SizedBox(
                  height: sy(12),
                  width: sy(18),
                  child: TextFormField(
                    initialValue: lessThan <= 0 ? '' : formatDecimal(lessThan),
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
                      var lessThan = trycatch(() => double.parse(value), 0.0);
                      if (value == null || value.isEmpty) {
                        lessThan = -1;
                      }
                      var updated = filter.copyWith(lessThan: lessThan);
                      updateFilter(updated);
                    },
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
                Text(
                  'Is more than ',
                  style: TextStyle(
                    fontSize: sy(10),
                    color: AppTheme.of(context).text3,
                  ),
                ),
                SizedBox(
                  height: sy(12),
                  width: sy(18),
                  child: TextFormField(
                    initialValue: moreThan >= 999999 ? '' : formatDecimal(moreThan),
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
                      var moreThan = trycatch(() => double.parse(value), 0.0);
                      if (value == null || value.isEmpty) {
                        moreThan = 999999;
                      }
                      var updated = filter.copyWith(moreThan: moreThan);
                      updateFilter(updated);
                    },
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

  void updateFilter(AnimeFilterDurationPerEpData filter) {
    animeFilter.controller.addFilter(filter);
  }
}
