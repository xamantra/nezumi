import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../components/anime-top/index.dart';
import '../../../mixins/index.dart';
import '../../../utils/index.dart';
import '../../index.dart';

class YearlyRankingAnimeListStatusDialog extends StatefulWidget {
  const YearlyRankingAnimeListStatusDialog({Key key}) : super(key: key);

  @override
  _YearlyRankingAnimeListStatusDialogState createState() => _YearlyRankingAnimeListStatusDialogState();
}

class _YearlyRankingAnimeListStatusDialogState extends State<YearlyRankingAnimeListStatusDialog> with CoreStateMixin {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return MomentumBuilder(
          controllers: [AnimeTopController],
          builder: (context, snapshot) {
            var widgets = <Widget>[];
            for (var lstatus in allAnimeStatusListExtra) {
              var checked = animeTop.showOnlyAnimeListStatus.any((x) => x == lstatus);
              widgets.add(
                Ripple(
                  onPressed: () {
                    animeTop.controller.toggleCheckAnimeListStatusFilter(lstatus);
                  },
                  child: ListTile(
                    title: Text(
                      normalizeSlug(lstatus),
                    ),
                    trailing: Checkbox(
                      value: checked,
                      activeColor: AppTheme.of(context).primary,
                      onChanged: (value) {
                        animeTop.controller.toggleCheckAnimeListStatusFilter(lstatus);
                      },
                    ),
                  ),
                ),
              );
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
