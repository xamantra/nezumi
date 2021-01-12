import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../components/anime-top/index.dart';
import '../../../mixins/index.dart';
import '../../index.dart';

class YearlyRankingAnimeTypesDialog extends StatefulWidget {
  const YearlyRankingAnimeTypesDialog({Key key}) : super(key: key);

  @override
  _YearlyRankingAnimeTypesDialogState createState() => _YearlyRankingAnimeTypesDialogState();
}

class _YearlyRankingAnimeTypesDialogState extends State<YearlyRankingAnimeTypesDialog> with CoreStateMixin {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: RelativeBuilder(
        builder: (context, height, width, sy, sx) {
          return MomentumBuilder(
            controllers: [AnimeTopController],
            builder: (context, snapshot) {
              var widgets = <Widget>[];
              for (var key in animeTop.showOnlyAnimeTypes.keys) {
                var checked = animeTop.showOnlyAnimeTypes[key];
                widgets.add(Ripple(
                  onPressed: () {
                    animeTop.controller.toggleCheckAnimeTypeFilter(key);
                  },
                  child: ListTile(
                    title: Text(
                      key,
                    ),
                    trailing: Checkbox(
                      value: checked,
                      activeColor: AppTheme.of(context).primary,
                      onChanged: (value) {
                        animeTop.controller.toggleCheckAnimeTypeFilter(key);
                      },
                    ),
                  ),
                ));
              }
              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: widgets,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
