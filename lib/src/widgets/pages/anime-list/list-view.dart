import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:nezumi/src/data/index.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../modules/my_anime_list/index.dart';
import '../../app-theme.dart';
import '../../index.dart';

class AnimeListView extends StatelessWidget {
  const AnimeListView({
    Key key,
    @required this.status,
  }) : super(key: key);

  final String status;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return MomentumBuilder(
          controllers: [MyAnimeListController],
          builder: (context, snapshot) {
            var mal = snapshot<MyAnimeListModel>();
            var list = mal.fullUserAnimeList.getByStatus(status);

            if (mal.loading) {
              return Loader();
            }

            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: list.length,
              itemBuilder: (context, index) {
                var anime = list[index];
                return AnimeItemCard(anime: anime);
              },
            );
          },
        );
      },
    );
  }
}

class AnimeItemCard extends StatelessWidget {
  const AnimeItemCard({Key key, @required this.anime}) : super(key: key);

  final AnimeData anime;

  @override
  Widget build(BuildContext context) {
    var color = AppTheme.of(context).secondaryBackground.withOpacity(0.6);
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Container(
          width: width,
          margin: EdgeInsets.all(sy(4)),
          padding: EdgeInsets.all(sy(8)),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 0.5),
                spreadRadius: 1,
                blurRadius: 1,
                color: Colors.black.withOpacity(0.1),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      anime.node.title,
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
                          anime.node.mediaType.toUpperCase(),
                          style: TextStyle(
                            color: AppTheme.of(context).text3,
                            fontWeight: FontWeight.w300,
                            fontSize: sy(7),
                          ),
                        ),
                        Dot(color: AppTheme.of(context).text3),
                        Text(
                          anime.node.status.toUpperCase(),
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
                    Row(
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
                          text: anime.node.source,
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
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
