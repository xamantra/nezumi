import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../components/anime-top/index.dart';
import '../../../mixins/index.dart';
import '../../../utils/index.dart';
import '../../index.dart';

class YearlyRankingAnimeAirStatusDialog extends StatefulWidget {
  const YearlyRankingAnimeAirStatusDialog({Key key}) : super(key: key);

  @override
  _YearlyRankingAnimeAirStatusDialogState createState() => _YearlyRankingAnimeAirStatusDialogState();
}

class _YearlyRankingAnimeAirStatusDialogState extends State<YearlyRankingAnimeAirStatusDialog> with CoreStateMixin {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return MomentumBuilder(
          controllers: [AnimeTopController],
          builder: (context, snapshot) {
            var widgets = <Widget>[];
            for (var status in allAnimeAiringStatusList) {
              var checked = animeTop.showOnlyAnimeAirStatus.any((x) => x == status);
              widgets.add(
                Ripple(
                  onPressed: () {
                    animeTop.controller.toggleCheckAnimeAirStatusFilter(status);
                  },
                  child: ListTile(
                    title: Text(
                      normalizeSlug(status),
                    ),
                    trailing: Checkbox(
                      value: checked,
                      activeColor: AppTheme.of(context).primary,
                      onChanged: (value) {
                        animeTop.controller.toggleCheckAnimeAirStatusFilter(status);
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
