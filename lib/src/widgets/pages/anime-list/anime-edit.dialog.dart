import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:nezumi/src/data/index.dart';
import 'package:nezumi/src/modules/my_anime_list/index.dart';
import 'package:nezumi/src/utils/index.dart';
import 'package:nezumi/src/widgets/index.dart';
import 'package:relative_scale/relative_scale.dart';

class EditAnimeDialog extends StatelessWidget {
  const EditAnimeDialog({
    Key key,
    this.anime,
  }) : super(key: key);

  final AnimeData anime;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: RelativeBuilder(
        builder: (context, height, width, sy, sx) {
          return MomentumBuilder(
            controllers: [MyAnimeListController],
            builder: (context, snapshot) {
              var mal = snapshot<MyAnimeListModel>();
              var anime = mal.controller.getAnime(this.anime?.node?.id);

              return Container(
                padding: EdgeInsets.all(sy(8)),
                width: width,
                decoration: BoxDecoration(
                  color: AppTheme.of(context).primaryBackground,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      anime.node.title,
                      style: TextStyle(
                        color: AppTheme.of(context).text3,
                        fontWeight: FontWeight.w600,
                        fontSize: sy(12),
                      ),
                    ),
                    mal.loading
                        ? Center(
                            child: Padding(
                              padding: EdgeInsets.all(sy(8)),
                              child: SizedBox(
                                height: sy(30),
                                width: sy(30),
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedButton(
                                height: sy(30),
                                width: sy(30),
                                child: Icon(
                                  Icons.add,
                                  size: sy(18),
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  ctrl<MyAnimeListController>(context).incrementEpisode(anime.node.id);
                                },
                              ),
                              Text(
                                anime.listStatus.numEpisodesWatched?.toString(),
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600,
                                  fontSize: sy(12),
                                ),
                              ),
                              SizedButton(
                                height: sy(30),
                                width: sy(30),
                                child: Icon(
                                  Icons.remove,
                                  size: sy(18),
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  ctrl<MyAnimeListController>(context).decrementEpisode(anime.node.id);
                                },
                              ),
                              Text(
                                ' / ${anime.realEpisodeCount}',
                                style: TextStyle(
                                  color: AppTheme.of(context).text3,
                                  fontWeight: FontWeight.w600,
                                  fontSize: sy(12),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
