import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../../data/index.dart';
import '../../../../data/types/index.dart';
import '../../../app-theme.dart';
import '../../../index.dart';

class GenreStatItem extends StatelessWidget {
  const GenreStatItem({
    Key key,
    @required this.data,
    @required this.sortBy,
  }) : super(key: key);

  final AnimeSummaryStatData data;
  final AnimeStatSort sortBy;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: width,
              margin: EdgeInsets.symmetric(vertical: sy(12)),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        data.name,
                        style: TextStyle(
                          fontSize: sy(12),
                          fontWeight: FontWeight.w600,
                          color: AppTheme.of(context).text2,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _StatDataPair(value: data.mean == 0 ? 'N/A' : data.mean.toStringAsFixed(2), label: 'mean'),
                          _StatDataPair(value: data.entries.length, label: 'entries'),
                          _StatDataPair(value: data.totalEpisodes, label: 'episodes'),
                          _StatDataPair(value: data.totalHours.toStringAsFixed(2), label: 'hours'),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  _SortByBadge(data: data, sortBy: sortBy),
                ],
              ),
            ),
            Divider(height: 1),
          ],
        );
      },
    );
  }
}

class _StatDataPair<T> extends StatelessWidget {
  const _StatDataPair({
    Key key,
    @required this.value,
    @required this.label,
  }) : super(key: key);

  final T value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Container(
          margin: EdgeInsets.only(right: sy(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$value',
                style: TextStyle(
                  fontSize: sy(9),
                  color: AppTheme.of(context).text4,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: sy(8),
                  color: AppTheme.of(context).text7,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SortByBadge extends StatelessWidget {
  const _SortByBadge({
    Key key,
    @required this.data,
    @required this.sortBy,
  }) : super(key: key);

  final AnimeSummaryStatData data;
  final AnimeStatSort sortBy;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        switch (sortBy) {
          case AnimeStatSort.mean:
            return Badge(
              color: AppTheme.of(context).primary,
              textColor: AppTheme.of(context).text1,
              text: data.mean == 0 ? 'N/A' : data.mean.toStringAsFixed(2),
              fontSize: sy(9),
            );
          case AnimeStatSort.entryCount:
            return Badge(
              color: AppTheme.of(context).primary,
              textColor: AppTheme.of(context).text1,
              text: data.entries.length.toString(),
              fontSize: sy(9),
            );
          case AnimeStatSort.episodeCount:
          case AnimeStatSort.entryCount:
            return Badge(
              color: AppTheme.of(context).primary,
              textColor: AppTheme.of(context).text1,
              text: data.totalEpisodes.toString(),
              fontSize: sy(9),
            );
          case AnimeStatSort.hoursWatched:
            return Badge(
              color: AppTheme.of(context).primary,
              textColor: AppTheme.of(context).text1,
              text: data.totalHours.toStringAsFixed(2),
              fontSize: sy(9),
            );
        }
        return SizedBox();
      },
    );
  }
}
