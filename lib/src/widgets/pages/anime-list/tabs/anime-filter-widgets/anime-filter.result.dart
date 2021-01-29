import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../../../components/anime-filter/index.dart';
import '../../../../../components/list-sort/index.dart';
import '../../../../../data/types/index.dart';
import '../../../../../mixins/index.dart';
import '../../../../builders/index.dart';
import '../../../../items/index.dart';
import 'index.dart';

class AnimeFilterResultView extends StatefulWidget {
  const AnimeFilterResultView({Key key}) : super(key: key);

  @override
  _AnimeFilterResultViewState createState() => _AnimeFilterResultViewState();
}

class _AnimeFilterResultViewState extends State<AnimeFilterResultView> with CoreStateMixin {
  @override
  Widget build(BuildContext context) {
    var compactMode = settings.compactMode;
    var listMode = settings.listMode;
    var fields = settings.getSelectedAnimeFields ?? [];
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return MomentumBuilder(
          controllers: [AnimeFilterController, ListSortController],
          builder: (context, snapshot) {
            var list = animeFilter.results ?? [];
            var entryCount = list.length;

            return Column(
              children: [
                Container(
                  width: width,
                  padding: EdgeInsets.all(sy(8)),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        AnimeFilterStatItem(
                          title: 'Results',
                          icon: Icons.sort,
                          value: '$entryCount',
                          label: 'entries',
                          color: Colors.deepPurple,
                        ),
                        SizedBox(width: sy(8)),
                        AnimeFilterStatItem(
                          title: 'Length',
                          icon: Icons.calendar_today,
                          value: '${animeFilter.controller.resultTotalDays()}',
                          label: 'days',
                          color: Colors.pink,
                        ),
                        SizedBox(width: sy(8)),
                        AnimeFilterStatItem(
                          title: 'Average',
                          icon: Icons.timeline,
                          value: '${animeFilter.controller.resultEpisodesPerEntry()}',
                          label: 'episodes/entry',
                          color: Colors.redAccent,
                        ),
                        SizedBox(width: sy(8)),
                        AnimeFilterStatItem(
                          title: 'Duration',
                          icon: Icons.timer_sharp,
                          value: '${animeFilter.controller.minutesPerEpisode()}',
                          label: 'minutes/episode',
                          color: Colors.purple,
                        ),
                        SizedBox(width: sy(8)),
                        AnimeFilterStatItem(
                          title: 'Episodes',
                          icon: Icons.filter_1,
                          value: '${animeFilter.controller.resultTotalEpisodes()}',
                          label: 'total episodes',
                          color: Colors.indigo,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: listMode
                      ? ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            var anime = list[index];
                            return AnimeItem(
                              anime: anime,
                              compactMode: compactMode,
                              listMode: listMode,
                              trailBuilder: (_, anime) {
                                switch (listSort.animeFilterSortBy) {
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
          },
        );
      },
    );
  }
}
