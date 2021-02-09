import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../../components/anime-stats/index.dart';
import '../../../../utils/index.dart';
import '../../../index.dart';
import '../stat-layouts/index.dart';

class AnimeStatGenre extends StatelessWidget {
  const AnimeStatGenre({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var stats = ctrl<AnimeStatsController>(context);
    var g = stats.getGenreStatItems();
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Container(
          height: height,
          width: width,
          padding: EdgeInsets.symmetric(horizontal: sy(8)),
          color: AppTheme.of(context).primaryBackground,
          child: ListView.builder(
            itemCount: g.length,
            itemBuilder: (_, index) {
              var data = g[index];
              return GenreStatItem(data: data);
            },
          ),
        );
      },
    );
  }
}
