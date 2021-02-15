import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../data/index.dart';
import '../../../data/types/index.dart';
import '../../index.dart';
import 'index.dart';

class AnimeStatPage extends StatelessWidget {
  const AnimeStatPage({
    Key key,
    @required this.statList,
    @required this.sortBy,
    this.normalizeLabel = true,
    this.labeler,
  }) : super(key: key);

  final List<AnimeSummaryStatData> statList;
  final AnimeStatSort sortBy;
  final bool normalizeLabel;
  final String Function(String) labeler;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Container(
          height: height,
          width: width,
          padding: EdgeInsets.symmetric(horizontal: sy(8)),
          color: AppTheme.of(context).primaryBackground,
          child: ListView.builder(
            itemCount: statList.length,
            itemBuilder: (_, index) {
              var data = statList[index];
              return AnimeSummaryStatWidget(
                data: data,
                sortBy: sortBy,
                normalizeLabel: normalizeLabel,
                labeler: labeler,
              );
            },
          ),
        );
      },
    );
  }
}
