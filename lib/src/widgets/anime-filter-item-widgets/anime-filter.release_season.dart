import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../data/filter-anime-types/index.dart';
import '../../mixins/index.dart';
import '../../modules/anime-filter/index.dart';
import '../../utils/index.dart';
import '../app-theme.dart';
import '../index.dart';

class AnimeFilterReleaseSeasonWidget extends StatefulWidget {
  const AnimeFilterReleaseSeasonWidget({Key key}) : super(key: key);

  @override
  _AnimeFilterReleaseSeasonWidgetState createState() => _AnimeFilterReleaseSeasonWidgetState();
}

class _AnimeFilterReleaseSeasonWidgetState extends State<AnimeFilterReleaseSeasonWidget> with CoreStateMixin {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return MomentumBuilder(
          controllers: [AnimeFilterController],
          builder: (context, snapshot) {
            var filter = animeFilter.getFilter<AnimeFilterReleaseSeasonData>();
            return Column(
              children: [
                SizedBox(height: sy(4)),
                Row(
                  children: [
                    PopupMenuButton<bool>(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: sy(8)),
                        child: Text(
                          filter.isExclude ? 'Exclude all: ' : 'Include only: ',
                          style: TextStyle(
                            color: filter.isExclude ? Colors.red : Colors.green,
                            fontSize: sy(9),
                          ),
                        ),
                      ),
                      onSelected: (value) {
                        var updated = filter.copyWith(isExclude: value);
                        updateFilter(updated);
                      },
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem<bool>(
                            value: false,
                            child: Text(
                              'Include only',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: sy(9),
                              ),
                            ),
                          ),
                          PopupMenuItem<bool>(
                            value: true,
                            child: Text(
                              'Exclude all',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: sy(9),
                              ),
                            ),
                          ),
                        ];
                      },
                    ),
                    Expanded(
                      child: HorizontalBadgeList(
                        items: filter.selectedSeasons,
                        color: filter.isExclude ? Colors.red : Colors.green,
                        itemCallback: (season) {
                          var newList = List<String>.from(filter.selectedSeasons);
                          newList.removeWhere((x) => x == season);
                          var updated = filter.copyWith(selectedSeasons: newList);
                          updateFilter(updated);
                        },
                      ),
                    ),
                    SizedButton(
                      height: sy(24),
                      width: sy(24),
                      radius: 100,
                      child: Icon(
                        Icons.add,
                        color: AppTheme.of(context).text4,
                        size: sy(16),
                      ),
                      onPressed: () {
                        chooseSeason(filter);
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

  void chooseSeason(AnimeFilterReleaseSeasonData filter) {
    dialog(context, _ChooseSeasonDialog());
  }

  void updateFilter(AnimeFilterReleaseSeasonData filter) {
    animeFilter.controller.addFilter(filter);
  }
}

class _ChooseSeasonDialog extends StatefulWidget {
  const _ChooseSeasonDialog({
    Key key,
  }) : super(key: key);

  @override
  __ChooseSeasonDialogState createState() => __ChooseSeasonDialogState();
}

class __ChooseSeasonDialogState extends State<_ChooseSeasonDialog> with CoreStateMixin {
  String year;
  String season;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    year = DateTime.now().year.toString();
    season = allAnimeSeasonNames.first;
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<String>(
                    dropdownColor: AppTheme.of(context).primaryBackground,
                    underline: SizedBox(),
                    value: season,
                    items: allAnimeSeasonNames
                        .map<DropdownMenuItem<String>>(
                          (season) => DropdownMenuItem<String>(
                            value: season,
                            child: Text(
                              season,
                              style: TextStyle(
                                color: AppTheme.of(context).text4,
                                fontSize: sy(10),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (season) {
                      setState(() {
                        this.season = season;
                      });
                    },
                  ),
                  SizedBox(width: sy(8)),
                  DropdownButton<String>(
                    dropdownColor: AppTheme.of(context).primaryBackground,
                    underline: SizedBox(),
                    value: year,
                    items: yearList
                        .map<DropdownMenuItem<String>>(
                          (year) => DropdownMenuItem<String>(
                            value: '$year',
                            child: Text(
                              '$year',
                              style: TextStyle(
                                color: AppTheme.of(context).text4,
                                fontSize: sy(10),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (year) {
                      setState(() {
                        this.year = year;
                      });
                    },
                  ),
                  SizedBox(width: sy(8)),
                  SizedButton(
                    height: sy(36),
                    width: sy(36),
                    child: Text(
                      'ADD',
                      style: TextStyle(
                        color: AppTheme.of(context).accent,
                        fontSize: sy(11),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onPressed: () {
                      var s = '$season $year';
                      var filter = animeFilter.getFilter<AnimeFilterReleaseSeasonData>();
                      var newList = List<String>.from(filter.selectedSeasons);
                      newList.add(s);
                      newList = newList.toSet().toList();
                      var updated = filter.copyWith(selectedSeasons: newList);
                      updateFilter(updated);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void updateFilter(AnimeFilterReleaseSeasonData filter) {
    animeFilter.controller.addFilter(filter);
  }
}
