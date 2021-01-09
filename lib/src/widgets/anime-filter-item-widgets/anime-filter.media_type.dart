import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../data/filter-anime-types/index.dart';
import '../../mixins/index.dart';
import '../../components/anime-filter/index.dart';
import '../../utils/index.dart';
import '../app-theme.dart';
import '../index.dart';

class AnimeFilterMediaTypeWidget extends StatefulWidget {
  const AnimeFilterMediaTypeWidget({Key key}) : super(key: key);

  @override
  _AnimeFilterMediaTypeWidgetState createState() => _AnimeFilterMediaTypeWidgetState();
}

class _AnimeFilterMediaTypeWidgetState extends State<AnimeFilterMediaTypeWidget> with CoreStateMixin {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return MomentumBuilder(
          controllers: [AnimeFilterController],
          builder: (context, snapshot) {
            var filter = animeFilter.getFilter<AnimeFilterMediaTypeData>();
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
                        items: filter.selectedMediaTypes
                            .map(
                              (e) => e.toUpperCase(),
                            )
                            ?.toList(),
                        color: filter.isExclude ? Colors.red : Colors.green,
                        itemCallback: (status) {
                          var newList = List<String>.from(filter.selectedMediaTypes);
                          newList.removeWhere((x) => x == slugify(status));
                          var updated = filter.copyWith(selectedMediaTypes: newList);
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
                        chooseStatus(filter);
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

  void chooseStatus(AnimeFilterMediaTypeData filter) {
    var widget = Dialog(
      backgroundColor: AppTheme.of(context).primaryBackground,
      child: RelativeBuilder(
        builder: (context, height, width, sy, sx) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: allAnimeMediaTypeList
                  .map(
                    (x) => Ripple(
                      child: Container(
                        height: sy(36),
                        width: width,
                        padding: EdgeInsets.all(sy(8)),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            x.toUpperCase(),
                            style: TextStyle(
                              fontSize: sy(10),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        var newList = List<String>.from(filter.selectedMediaTypes);
                        newList.add(x);
                        newList = newList.toSet().toList();
                        var updated = filter.copyWith(selectedMediaTypes: newList);
                        updateFilter(updated);
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

  void updateFilter(AnimeFilterMediaTypeData filter) {
    animeFilter.controller.addFilter(filter);
  }
}
