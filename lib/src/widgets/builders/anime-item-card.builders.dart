import 'package:flutter/material.dart';
import 'package:number_display/number_display.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../data/index.dart';
import '../index.dart';

Widget buildAnimeIndexNumber(BuildContext context, int index, AnimeDetails anime) {
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

Widget buildAnimeScore(BuildContext context, int index, AnimeDetails anime) {
  return RelativeBuilder(
    builder: (context, height, width, sy, sx) {
      return Container(
        height: sy(28),
        child: Badge(
          color: AppTheme.of(context).primary,
          textColor: Colors.white,
          text: (anime?.mean ?? 0).toStringAsFixed(2),
          fontSize: sy(10),
        ),
      );
    },
  );
}

Widget buildAnimePopularity(BuildContext context, int index, AnimeDetails anime) {
  return RelativeBuilder(
    builder: (context, height, width, sy, sx) {
      final display = createDisplay(length: 99);
      return Container(
        height: sy(28),
        padding: EdgeInsets.only(left: sy(2)),
        child: Badge(
          color: AppTheme.of(context).primary,
          textColor: Colors.white,
          text: display((anime?.numListUsers ?? 0)),
          fontSize: sy(10),
        ),
      );
    },
  );
}

Widget buildAnimeScoringUsers(BuildContext context, int index, AnimeDetails anime) {
  return RelativeBuilder(
    builder: (context, height, width, sy, sx) {
      final display = createDisplay(length: 99);
      return Container(
        height: sy(28),
        padding: EdgeInsets.only(left: sy(2)),
        child: Badge(
          color: AppTheme.of(context).primary,
          textColor: Colors.white,
          text: display((anime?.numScoringUsers ?? 0)),
          fontSize: sy(10),
        ),
      );
    },
  );
}

Widget buildAnimeEpisodesWatched(BuildContext context, int index, AnimeDetails anime) {
  return RelativeBuilder(
    builder: (context, height, width, sy, sx) {
      final display = createDisplay(length: 99);
      return Container(
        height: sy(28),
        padding: EdgeInsets.only(left: sy(2)),
        child: Badge(
          color: AppTheme.of(context).primary,
          textColor: Colors.white,
          text: display((anime?.myListStatus?.numEpisodesWatched ?? 0)),
          fontSize: sy(10),
        ),
      );
    },
  );
}

Widget buildAnimeStartWatch(BuildContext context, int index, AnimeDetails anime) {
  return RelativeBuilder(
    builder: (context, height, width, sy, sx) {
      var start = anime?.myListStatus?.startDate;
      if (start == null) return SizedBox();
      return Container(
        height: sy(28),
        padding: EdgeInsets.only(left: sy(2)),
        child: Badge(
          color: AppTheme.of(context).primary,
          textColor: Colors.white,
          text: start,
          fontSize: sy(10),
        ),
      );
    },
  );
}

Widget buildAnimeFinishWatch(BuildContext context, int index, AnimeDetails anime) {
  return RelativeBuilder(
    builder: (context, height, width, sy, sx) {
      var finish = anime?.myListStatus?.finishDate;
      if (finish == null) return SizedBox();
      return Container(
        height: sy(28),
        padding: EdgeInsets.only(left: sy(2)),
        child: Badge(
          color: AppTheme.of(context).primary,
          textColor: Colors.white,
          text: finish,
          fontSize: sy(10),
        ),
      );
    },
  );
}

Widget buildAnimeLastUpdated(BuildContext context, int index, AnimeDetails anime) {
  return RelativeBuilder(
    builder: (context, height, width, sy, sx) {
      var updatedAt = anime?.myListStatus?.updatedAt;
      if (updatedAt == null) return SizedBox();
      var lastUpdated = timeago.format(updatedAt);
      return Container(
        height: sy(28),
        padding: EdgeInsets.only(left: sy(2)),
        child: Badge(
          color: AppTheme.of(context).primary,
          textColor: Colors.white,
          text: lastUpdated,
          fontSize: sy(10),
        ),
      );
    },
  );
}

Widget buildAnimeTotalDuration(BuildContext context, int index, AnimeDetails anime) {
  return RelativeBuilder(
    builder: (context, height, width, sy, sx) {
      return Container(
        height: sy(28),
        padding: EdgeInsets.only(left: sy(2)),
        child: Badge(
          color: AppTheme.of(context).primary,
          textColor: Colors.white,
          text: anime.totalDuration.toString(),
          fontSize: sy(10),
        ),
      );
    },
  );
}

Widget buildAnimeFavorites(BuildContext context, int index, AnimeDetails anime) {
  return RelativeBuilder(
    builder: (context, height, width, sy, sx) {
      return SizedBox();
    },
  );
}
