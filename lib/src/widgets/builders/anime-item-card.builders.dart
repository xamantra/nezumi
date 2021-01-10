import 'package:flutter/material.dart';
import 'package:number_display/number_display.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../data/index.dart';
import '../index.dart';

Widget buildAnimeGlobalItemIndexNumber(BuildContext context, int index, AnimeDataItem anime) {
  return RelativeBuilder(
    builder: (context, height, width, sy, sx) {
      return Padding(
        padding: EdgeInsets.only(right: sy(8)),
        child: Text(
          '${index + 1}.',
          style: TextStyle(
            color: AppTheme.of(context).accent,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
            fontSize: sy(12),
          ),
        ),
      );
    },
  );
}

Widget buildAnimeGlobalItemScore(BuildContext context, int index, AnimeDataItem anime) {
  return RelativeBuilder(
    builder: (context, height, width, sy, sx) {
      return Container(
        height: sy(32),
        child: Badge(
          color: AppTheme.of(context).primary,
          textColor: Colors.white,
          text: (anime?.node?.mean ?? 0).toStringAsFixed(2),
          fontSize: sy(10),
        ),
      );
    },
  );
}

Widget buildAnimeGlobalItemPopularity(BuildContext context, int index, AnimeDataItem anime) {
  return RelativeBuilder(
    builder: (context, height, width, sy, sx) {
      final display = createDisplay(length: 99);
      return Container(
        height: sy(32),
        padding: EdgeInsets.only(left: sy(2)),
        child: Badge(
          color: AppTheme.of(context).primary,
          textColor: Colors.white,
          text: display((anime?.node?.numListUsers ?? 0)),
          fontSize: sy(10),
        ),
      );
    },
  );
}

Widget buildAnimeGlobalItemFavorites(BuildContext context, int index, AnimeDataItem anime) {
  return RelativeBuilder(
    builder: (context, height, width, sy, sx) {
      return SizedBox();
    },
  );
}
