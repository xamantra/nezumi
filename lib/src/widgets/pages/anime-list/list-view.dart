import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../components/list-sort/index.dart';
import '../../../components/my_anime_list/index.dart';
import '../../../data/types/index.dart';
import '../../../mixins/index.dart';
import '../../builders/index.dart';
import '../../index.dart';
import '../../items/index.dart';

class AnimeListView extends StatefulWidget {
  const AnimeListView({
    Key key,
    @required this.status,
  }) : super(key: key);

  final String status;

  @override
  _AnimeListViewState createState() => _AnimeListViewState();
}

class _AnimeListViewState extends State<AnimeListView> with CoreStateMixin {
  final RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    var compactMode = appSettings.compactMode;
    var fields = settings.getSelectedAnimeFields ?? [];
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return MomentumBuilder(
          controllers: [MyAnimeListController, ListSortController],
          builder: (context, snapshot) {
            var list = mal.userAnimeList?.getByStatus(widget.status);

            if (mal.loading) {
              return Loader();
            }

            return SmartRefresher(
              physics: BouncingScrollPhysics(),
              controller: refreshController,
              onRefresh: () {
                mal.controller.loadAnimeListByStatus(widget.status);
              },
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  var anime = list[index];
                  return AnimeItemCard(
                    anime: anime,
                    compactMode: compactMode,
                    index: index,
                    trailBuilder: (_, anime) {
                      switch (listSort.animeListSortBy) {
                        case AnimeListSortBy.title:
                          break;
                        case AnimeListSortBy.globalScore:
                          return buildAnimeScore(context, index, anime);
                        case AnimeListSortBy.member:
                          return buildAnimePopularity(context, index, anime);
                        case AnimeListSortBy.userVotes:
                          return buildAnimeScoringUsers(context, index, anime);
                        case AnimeListSortBy.lastUpdated:
                          return buildAnimeLastUpdated(context, index, anime);
                        case AnimeListSortBy.episodesWatched:
                          return buildAnimeEpisodesWatched(context, index, anime);
                        case AnimeListSortBy.startWatchDate:
                          return buildAnimeStartWatch(context, index, anime);
                        case AnimeListSortBy.finishWatchDate:
                          return buildAnimeFinishWatch(context, index, anime);
                        case AnimeListSortBy.personalScore:
                          return buildAnimePersonalScore(context, index, anime);
                        case AnimeListSortBy.totalDuration:
                          return buildAnimeTotalDuration(context, index, anime);
                      }
                      return SizedBox();
                    },
                    fieldsBuilder: (context, anime) => buildAnimeListFields(context, anime, fields, compactMode),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
