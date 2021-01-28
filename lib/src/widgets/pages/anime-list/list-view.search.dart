import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../components/anime-search/index.dart';
import '../../../data/types/index.dart';
import '../../../mixins/index.dart';
import '../../builders/index.dart';
import '../../index.dart';
import '../../items/index.dart';

class AnimeSearchListView extends StatefulWidget {
  const AnimeSearchListView({
    Key key,
    this.isMyListResults = true,
  }) : super(key: key);

  final bool isMyListResults;

  @override
  _AnimeSearchListViewState createState() => _AnimeSearchListViewState();
}

class _AnimeSearchListViewState extends State<AnimeSearchListView> with CoreStateMixin {
  final RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    var compactMode = settings.compactMode;
    var listMode = settings.listMode;
    var fields = settings.getSelectedAnimeFields ?? [];
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return MomentumBuilder(
          controllers: [AnimeSearchController],
          builder: (context, snapshot) {
            if (widget.isMyListResults) {
              var list = animeSearch.listResults ?? [];
              if (list.isEmpty) {
                return Center(
                  child: Text(
                    'There\'s nothing here.',
                    style: TextStyle(
                      color: AppTheme.of(context).text7,
                      fontSize: sy(12),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                );
              }

              return listMode
                  ? ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        var anime = list[index];
                        var inMyList = mal.controller.inMyList(anime?.id);
                        return AnimeItem(
                          anime: anime,
                          compactMode: compactMode,
                          listMode: listMode,
                          editMode: inMyList,
                          trailBuilder: (_, anime) {
                            switch (listSort.animeSearchSortBy) {
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
                              case AnimeListSortBy.startAirDate:
                                return buildAnimeStartAir(context, index, anime);
                              case AnimeListSortBy.endAirDate:
                                return buildAnimeEndAir(context, index, anime);
                            }
                            return SizedBox();
                          },
                          fieldsBuilder: (context, anime) => buildAnimeListFields(context, anime, fields, compactMode),
                        );
                      },
                    )
                  : GridView.builder(
                      physics: BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: compactMode ? 4 : 3,
                        childAspectRatio: 1 / 1.3,
                      ),
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        var anime = list[index];
                        return AnimeItem(anime: anime, compactMode: compactMode, listMode: listMode, index: index);
                      },
                    );
            } else {
              var loading = animeSearch.loadingResult ?? false;
              if (loading) {
                return Loader();
              }
              if (animeSearch.results.isEmpty) {
                return Center(
                  child: Text(
                    'There\'s nothing here.',
                    style: TextStyle(
                      color: AppTheme.of(context).text7,
                      fontSize: sy(12),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                );
              }

              var list = animeSearch.results ?? [];
              return Column(
                children: [
                  Paginator(
                    currentPage: animeSearch.currentPage,
                    prevEnabled: animeSearch.prevPage.isNotEmpty,
                    nextEnabled: animeSearch.nextPage.isNotEmpty,
                    onPrev: animeSearch.controller.gotoPrevPageMALSearch,
                    onNext: animeSearch.controller.gotoNextPageMALSearch,
                  ),
                  Expanded(
                    child: listMode
                        ? ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              var anime = list[index];
                              var inMyList = mal.controller.inMyList(anime?.id);
                              return AnimeItem(
                                anime: anime,
                                compactMode: compactMode,
                                listMode: listMode,
                                editMode: inMyList,
                                trailBuilder: (_, anime) {
                                  switch (listSort.animeSearchSortBy) {
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
                                    case AnimeListSortBy.startAirDate:
                                      return buildAnimeStartAir(context, index, anime);
                                    case AnimeListSortBy.endAirDate:
                                      return buildAnimeEndAir(context, index, anime);
                                  }
                                  return SizedBox();
                                },
                                fieldsBuilder: (context, anime) => buildAnimeListFields(context, anime, fields, compactMode),
                              );
                            },
                          )
                        : GridView.builder(
                            physics: BouncingScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: compactMode ? 4 : 3,
                              childAspectRatio: 1 / 1.3,
                            ),
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              var anime = list[index];
                              return AnimeItem(anime: anime, compactMode: compactMode, listMode: listMode, index: index);
                            },
                          ),
                  ),
                ],
              );
            }
          },
        );
      },
    );
  }
}
