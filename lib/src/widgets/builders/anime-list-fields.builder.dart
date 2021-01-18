import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../data/index.dart';
import '../../data/types/index.dart';
import '../index.dart';

Widget buildAnimeListFields(
  BuildContext context,
  AnimeDetails anime,
  List<AnimeListField> selectedAnimeFields,
  bool compactMode,
) {
  var separator = Dot(color: AppTheme.of(context).text7);
  return RelativeBuilder(
    builder: (context, height, width, sy, sx) {
      var fields = selectedAnimeFields..removeWhere((x) => x == AnimeListField.title);
      var length = fields.length;
      var widgets = <Widget>[];
      for (var i = 0; i < length; i++) {
        var field = fields[i];
        Widget widget = SizedBox();
        switch (field) {
          case AnimeListField.title:
            break;
          case AnimeListField.format:
            widget = Text(
              anime?.mediaType?.toUpperCase(),
              style: TextStyle(
                color: AppTheme.of(context).text4,
                fontWeight: FontWeight.w300,
                fontSize: sy(7),
              ),
              overflow: TextOverflow.ellipsis,
            );
            break;
          case AnimeListField.season:
            widget = Text(
              anime.season,
              style: TextStyle(
                color: AppTheme.of(context).text4,
                fontWeight: FontWeight.w300,
                fontSize: sy(7),
              ),
              overflow: TextOverflow.ellipsis,
            );
            break;
          case AnimeListField.airingStatus:
            widget = Text(
              anime.animeStatus,
              style: TextStyle(
                color: AppTheme.of(context).text4,
                fontWeight: FontWeight.w300,
                fontSize: sy(7),
              ),
              overflow: TextOverflow.ellipsis,
            );
            break;
          case AnimeListField.listStatus:
            widget = Text(
              anime.listStatus,
              style: TextStyle(
                color: AppTheme.of(context).text4,
                fontWeight: FontWeight.w300,
                fontSize: sy(7),
              ),
              overflow: TextOverflow.ellipsis,
            );
            break;
          case AnimeListField.episodeCount:
            widget = Text(
              '${anime.numEpisodes == 0 ? "??" : anime.numEpisodes} eps',
              style: TextStyle(
                color: AppTheme.of(context).text4,
                fontWeight: FontWeight.w300,
                fontSize: sy(7),
              ),
              overflow: TextOverflow.ellipsis,
            );
            break;
          case AnimeListField.episodesWatched:
            widget = Text(
              '${anime.myListStatus?.numEpisodesWatched?.toString() ?? 0} watched eps',
              style: TextStyle(
                color: AppTheme.of(context).text4,
                fontWeight: FontWeight.w300,
                fontSize: sy(7),
              ),
              overflow: TextOverflow.ellipsis,
            );
            break;
          case AnimeListField.durationPerEpisode:
            widget = Text(
              '${anime.durationPerEp == 0 ? "Unknown" : anime.durationPerEp} mins/ep',
              style: TextStyle(
                color: AppTheme.of(context).text4,
                fontWeight: FontWeight.w300,
                fontSize: sy(7),
              ),
              overflow: TextOverflow.ellipsis,
            );
            break;
          case AnimeListField.totalDuration:
            widget = Text(
              '${anime.totalDuration == 0 ? "Unknown" : anime.totalDuration}',
              style: TextStyle(
                color: AppTheme.of(context).text4,
                fontWeight: FontWeight.w300,
                fontSize: sy(7),
              ),
              overflow: TextOverflow.ellipsis,
            );
            break;
          case AnimeListField.sourceMaterial:
            widget = Text(
              anime.sourceFormatted,
              style: TextStyle(
                color: AppTheme.of(context).text4,
                fontWeight: FontWeight.w300,
                fontSize: sy(7),
              ),
              overflow: TextOverflow.ellipsis,
            );
            break;
          case AnimeListField.studios:
            if (anime.studiosFormatted.isEmpty) {
              widget = Text(
                'Unknown Studio',
                style: TextStyle(
                  color: AppTheme.of(context).text6,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                  fontSize: sy(7),
                ),
                overflow: TextOverflow.ellipsis,
              );
            } else {
              widget = RowSeparator(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: anime.studiosFormatted
                    .map((e) => Text(
                          e,
                          style: TextStyle(
                            color: AppTheme.of(context).text4,
                            fontWeight: FontWeight.w300,
                            fontSize: sy(7),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ))
                    .toList(),
                separator: separator,
              );
            }
            break;
          case AnimeListField.ageRating:
            widget = Text(
              anime.rating?.toUpperCase() ?? 'Unknown',
              style: TextStyle(
                color: AppTheme.of(context).text4,
                fontWeight: FontWeight.w300,
                fontSize: sy(7),
              ),
              overflow: TextOverflow.ellipsis,
            );
            break;
        }
        widgets.add(widget);
      }

      if (length == 0) {
        return SizedBox();
      } else if (length <= 3 || compactMode) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: sy(2)),
            RowSeparator(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: compactMode ? widgets.sublist(0, 3) : widgets,
              separator: separator,
            ),
          ],
        );
      } else if (length > 3 && length <= 6) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: sy(2)),
            RowSeparator(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: widgets.sublist(0, 3),
              separator: separator,
            ),
            SizedBox(height: sy(2)),
            RowSeparator(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: widgets.sublist(3),
              separator: separator,
            ),
          ],
        );
      } else {
        return SizedBox();
      }
    },
  );
}
