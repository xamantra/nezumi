import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../data/index.dart';
import '../../index.dart';

class AnimeGlobalItemCard extends StatelessWidget {
  const AnimeGlobalItemCard({
    Key key,
    @required this.anime,
    this.editMode = true,
    this.leadBuilder,
    this.trailBuilder,
  }) : super(key: key);

  final AnimeDataItem anime;
  final bool editMode;
  final Widget Function(BuildContext context, AnimeDataItem anime) leadBuilder;
  final Widget Function(BuildContext context, AnimeDataItem anime) trailBuilder;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        var actions = [
          Container(
            padding: EdgeInsets.symmetric(vertical: sy(4)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: IconSlideAction(
                color: Colors.transparent,
                iconWidget: Icon(
                  editMode ? Icons.edit : Icons.add,
                  size: sy(20),
                  color: Colors.blue,
                ),
                onTap: () {
                  // TODO: add anime mode.
                  // ctrl<AnimeUpdateController>(context).setCurrentAnime(anime);
                  // dialog(context, EditAnimeDialog(anime: anime));
                },
                closeOnTap: false,
              ),
            ),
          ),
        ];
        return Slidable(
          actionPane: SlidableStrechActionPane(),
          actionExtentRatio: 0.25,
          child: Container(
            width: width,
            margin: EdgeInsets.symmetric(vertical: sy(4)),
            color: Colors.transparent,
            child: Ripple(
              padding: sy(8),
              onPressed: () {},
              radius: 0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  leadBuilder != null ? leadBuilder(context, anime) : SizedBox(),
                  SymmetricImage(
                    url: anime?.node?.mainPicture?.medium ?? '',
                    size: sy(36),
                  ),
                  SizedBox(width: sy(8)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          anime.node?.title,
                          style: TextStyle(
                            color: AppTheme.of(context).text3,
                            fontWeight: FontWeight.w600,
                            fontSize: sy(10),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: sy(4)),
                        Row(
                          children: [
                            Text(
                              anime?.node?.mediaType?.toUpperCase(),
                              style: TextStyle(
                                color: AppTheme.of(context).text4,
                                fontWeight: FontWeight.w300,
                                fontSize: sy(7),
                              ),
                            ),
                            Dot(color: AppTheme.of(context).text5),
                            Text(
                              anime.animeStatus,
                              style: TextStyle(
                                color: AppTheme.of(context).text4,
                                fontWeight: FontWeight.w300,
                                fontSize: sy(7),
                              ),
                            ),
                            Dot(color: AppTheme.of(context).text5),
                            Text(
                              '${anime.durationPerEpisode} mins x ${anime.episodeCount}',
                              style: TextStyle(
                                color: AppTheme.of(context).text4,
                                fontWeight: FontWeight.w300,
                                fontSize: sy(7),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: sy(4)),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Text(
                                anime.season,
                                style: TextStyle(
                                  color: AppTheme.of(context).text4,
                                  fontWeight: FontWeight.w300,
                                  fontSize: sy(7),
                                ),
                              ),
                              Dot(color: AppTheme.of(context).text5),
                              Text(
                                anime.source,
                                style: TextStyle(
                                  color: AppTheme.of(context).text4,
                                  fontWeight: FontWeight.w300,
                                  fontSize: sy(7),
                                ),
                              ),
                            ]..addAll(anime.studios.map(
                                (e) => Row(
                                  children: [
                                    Dot(color: AppTheme.of(context).text5),
                                    Text(
                                      e,
                                      style: TextStyle(
                                        color: AppTheme.of(context).text4,
                                        fontWeight: FontWeight.w300,
                                        fontSize: sy(7),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  trailBuilder != null ? trailBuilder(context, anime) : SizedBox(),
                ],
              ),
            ),
          ),
          actions: actions,
          secondaryActions: actions,
        );
      },
    );
  }
}
