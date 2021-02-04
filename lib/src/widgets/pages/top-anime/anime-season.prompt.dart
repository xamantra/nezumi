import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../components/anime-top/index.dart';
import '../../../mixins/index.dart';
import '../../../utils/index.dart';
import '../../index.dart';

class YearlyRankingAnimeSeasonDialog extends StatefulWidget {
  const YearlyRankingAnimeSeasonDialog({Key key}) : super(key: key);

  @override
  _YearlyRankingAnimeSeasonDialogState createState() => _YearlyRankingAnimeSeasonDialogState();
}

class _YearlyRankingAnimeSeasonDialogState extends State<YearlyRankingAnimeSeasonDialog> with CoreStateMixin {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return MomentumBuilder(
          controllers: [AnimeTopController],
          builder: (context, snapshot) {
            var widgets = <Widget>[];
            for (var season in allAnimeSeasonNames) {
              var checked = animeTop.showOnlyAnimeSeason.any((x) => x == season);
              widgets.add(Ripple(
                onPressed: () {
                  animeTop.controller.toggleCheckAnimeSeasonFilter(season);
                },
                child: ListTile(
                  title: Text(
                    season,
                  ),
                  trailing: Checkbox(
                    value: checked,
                    activeColor: AppTheme.of(context).primary,
                    onChanged: (value) {
                      animeTop.controller.toggleCheckAnimeSeasonFilter(season);
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
    );
  }
}
