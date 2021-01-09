import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../data/index.dart';
import '../../index.dart';

class AnimeSearchItemCard extends StatelessWidget {
  const AnimeSearchItemCard({Key key, @required this.anime}) : super(key: key);

  final AnimeSearchItem anime;

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
                  Icons.edit,
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
                children: [
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
                                color: AppTheme.of(context).text3,
                                fontWeight: FontWeight.w300,
                                fontSize: sy(7),
                              ),
                            ),
                            Dot(color: AppTheme.of(context).text3),
                            Text(
                              anime.animeStatus,
                              style: TextStyle(
                                color: AppTheme.of(context).text3,
                                fontWeight: FontWeight.w300,
                                fontSize: sy(7),
                              ),
                            ),
                            Dot(color: AppTheme.of(context).text3),
                            Text(
                              '${anime.durationPerEpisode} mins x ${anime.episodeCount}',
                              style: TextStyle(
                                color: AppTheme.of(context).text3,
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
                              Badge(
                                color: Colors.teal,
                                textColor: Colors.white,
                                text: anime.season,
                                fontSize: sy(6),
                              ),
                              SizedBox(width: sy(4)),
                              Badge(
                                color: Colors.redAccent,
                                textColor: Colors.white,
                                text: anime.source,
                                fontSize: sy(6),
                              ),
                            ]..addAll(anime.studios.map(
                                (e) => Row(
                                  children: [
                                    SizedBox(width: sy(4)),
                                    Badge(
                                      color: Colors.purple,
                                      textColor: Colors.white,
                                      text: e,
                                      fontSize: sy(6),
                                    ),
                                  ],
                                ),
                              )),
                          ),
                        ),
                      ],
                    ),
                  ),
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
