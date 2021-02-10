import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../../components/anime-stats/index.dart';
import '../../../index.dart';
import '../index.dart';

class AnimeStatSourceMaterial extends StatelessWidget {
  const AnimeStatSourceMaterial({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Container(
          height: height,
          width: width,
          padding: EdgeInsets.symmetric(horizontal: sy(8)),
          color: AppTheme.of(context).primaryBackground,
          child: MomentumBuilder(
            controllers: [AnimeStatsController],
            builder: (context, snapshot) {
              var model = snapshot<AnimeStatsModel>();
              var sortBy = model.sortBy;
              var g = model.controller.getSourceMaterialStatItems();
              return ListView.builder(
                itemCount: g.length,
                itemBuilder: (_, index) {
                  var data = g[index];
                  return AnimeSummaryStatWidget(data: data, sortBy: sortBy);
                },
              );
            },
          ),
        );
      },
    );
  }
}
