import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../../components/anime-top/index.dart';
import '../../../../components/export-list/index.dart';
import '../../../../components/list-sort/index.dart';
import '../../../../data/index.dart';
import '../../../../data/types/index.dart';
import '../../../../mixins/index.dart';
import '../../../../utils/index.dart';
import '../../../builders/index.dart';
import '../../../index.dart';
import '../index.dart';

class YearlyAnimeRankingPage extends StatefulWidget {
  const YearlyAnimeRankingPage({Key key}) : super(key: key);

  @override
  _YearlyAnimeRankingPageState createState() => _YearlyAnimeRankingPageState();
}

class _YearlyAnimeRankingPageState extends MomentumState<YearlyAnimeRankingPage> with AuthStateMixin, CoreStateMixin, SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tabController = TabController(length: 9, vsync: this);
    if (animeTop.controller.getCurrentYearRankList().isEmpty) {
      animeTop.controller.loadYearRankings();
    }

    exportList.controller.listen<ExportListEvent>(
      state: this,
      invoke: (event) {
        showToast(
          event.message,
          color: Colors.green,
          fontSize: 14,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Stack(
          children: [
            Container(
              height: height,
              width: width,
              color: animeTop.fullscreen ? Colors.transparent : AppTheme.of(context).primary,
            ),
            SafeArea(
              child: Column(
                children: [
                  MomentumBuilder(
                    controllers: [AnimeTopController, ListSortController],
                    builder: (context, snapshot) {
                      if (animeTop.fullscreen) {
                        return SizedBox();
                      }
                      return Toolbar(
                        height: sy(42),
                        leadingIcon: Icons.menu,
                        title: 'Top Anime',
                        actions: [
                          // hidden feature
                          malAccountId != 11090858
                              ? SizedBox()
                              : ToolbarAction(
                                  icon: Icons.import_export_outlined,
                                  onPressed: () {
                                    var list = animeTop.getRankingByYear(animeTop.selectedYear);
                                    var items = list
                                        .map<ExportAnimeItem>(
                                          (item) => ExportAnimeItem.fromAnimeDataItem(item),
                                        )
                                        .toList();
                                    var fields = [ExportAnimeField.title, ExportAnimeField.mean];
                                    exportList.controller.exportRedditTable(fields: fields, items: items);
                                  },
                                ),
                          ToolbarAction(
                            icon: Icons.more_vert,
                            onPressed: () {
                              dialog(context, YearlyRankingAnimeTypesDialog());
                            },
                          ),
                        ],
                        leadingAction: () {
                          Scaffold.of(context).openDrawer();
                        },
                      );
                    },
                  ),
                  MomentumBuilder(
                    controllers: [AnimeTopController],
                    builder: (context, snapshot) {
                      IconData orderByIcon;
                      IconData sortByIcon;
                      String orderBy;
                      switch (listSort.animeYearlyOrderBy) {
                        case OrderBy.ascending:
                          orderByIcon = Icons.arrow_upward;
                          sortByIcon = CustomIcons.sort_amount_up;
                          orderBy = 'Ascending';
                          break;
                        case OrderBy.descending:
                          orderByIcon = Icons.arrow_downward;
                          sortByIcon = CustomIcons.sort_amount_down;
                          orderBy = 'Descending';
                          break;
                      }
                      return RelativeBuilder(
                        scale: animeTop.fullscreen ? 0.8 : 1,
                        builder: (context, height, width, sy, sx) {
                          return Container(
                            height: sy(30),
                            color: animeTop.fullscreen ? Colors.transparent : AppTheme.of(context).primary,
                            padding: EdgeInsets.symmetric(horizontal: sy(6)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedButton(
                                  height: sy(32),
                                  width: sy(32),
                                  radius: 100,
                                  enabled: !animeTop.loadingYearlyRankings,
                                  child: Icon(
                                    Icons.chevron_left,
                                    size: sy(16),
                                  ),
                                  onPressed: () {
                                    animeTop.controller.prevYear();
                                  },
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    if (animeTop.loadingYearlyRankings) return;
                                    var picker = Dialog(
                                      // ignore: deprecated_member_use
                                      child: YearPicker(
                                        selectedDate: DateTime(animeTop.selectedYear, 1, 1),
                                        firstDate: DateTime.now().subtract(Duration(days: 365 * 120)),
                                        lastDate: DateTime.now(),
                                        onChanged: (value) {
                                          animeTop.controller.changeYear(value.year);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    );
                                    dialog(context, picker);
                                  },
                                  child: Text(
                                    '${animeTop.selectedYear}',
                                    style: TextStyle(
                                      fontSize: sy(11),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedButton(
                                  height: sy(32),
                                  width: sy(32),
                                  radius: 100,
                                  enabled: !animeTop.loadingYearlyRankings,
                                  child: Icon(
                                    Icons.chevron_right,
                                    size: sy(16),
                                  ),
                                  onPressed: () {
                                    animeTop.controller.nextYear();
                                  },
                                ),
                                ToolbarAction(
                                  icon: orderByIcon,
                                  size: sy(32),
                                  iconSize: sy(13),
                                  tooltip: orderBy,
                                  onPressed: () {
                                    listSort.controller.toggleAnimeYearlyOrderBy();
                                  },
                                ),
                                YearlyAnimeRankingSortMenu(
                                  value: listSort.animeYearlySortBy,
                                  iconSize: sy(10),
                                  orderByIcon: sortByIcon,
                                  onChanged: (sortBy) {
                                    listSort.controller.changeAnimeYearlySortBy(sortBy);
                                  },
                                ),
                                ToolbarAction(
                                  icon: Icons.remove_red_eye,
                                  size: sy(32),
                                  iconSize: sy(13),
                                  tooltip: 'View excluded',
                                  onPressed: () {
                                    push(
                                      context,
                                      AnimeTopListExlcudedView(
                                        leadBuilder: buildAnimeIndexNumber,
                                        trailBuilder: _buildTrailWidget,
                                      ),
                                    );
                                  },
                                ),
                                ToolbarAction(
                                  icon: animeTop.fullscreen ? Icons.fullscreen_exit_sharp : Icons.fullscreen_sharp,
                                  size: sy(32),
                                  iconSize: sy(13),
                                  tooltip: 'Toggle fullscreen',
                                  onPressed: () {
                                    animeTop.controller.toggleFullscreen();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                  Expanded(
                    child: Container(
                      color: AppTheme.of(context).primaryBackground,
                      child: MomentumBuilder(
                        controllers: [AnimeTopController],
                        builder: (context, snapshot) {
                          return AnimeTopYearlyView(
                            leadBuilder: buildAnimeIndexNumber,
                            trailBuilder: _buildTrailWidget,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTrailWidget(BuildContext context, int index, AnimeDetails anime) {
    switch (listSort.animeYearlySortBy) {
      case AnimeListSortBy.title:
        break;
      case AnimeListSortBy.globalScore:
        return buildAnimeScore(context, index, anime);
        break;
      case AnimeListSortBy.member:
        return buildAnimePopularity(context, index, anime);
        break;
      case AnimeListSortBy.userVotes:
        return buildAnimeScoringUsers(context, index, anime);
        break;
      case AnimeListSortBy.totalDuration:
        return buildAnimeTotalDuration(context, index, anime);
        break;
      case AnimeListSortBy.lastUpdated:
        return buildAnimeLastUpdated(context, index, anime);
        break;
      case AnimeListSortBy.personalScore:
        return buildAnimePersonalScore(context, index, anime);
        break;
      case AnimeListSortBy.episodesWatched:
        return buildAnimeEpisodesWatched(context, index, anime);
        break;
      case AnimeListSortBy.startWatchDate:
        return buildAnimeStartWatch(context, index, anime);
        break;
      case AnimeListSortBy.finishWatchDate:
        return buildAnimeFinishWatch(context, index, anime);
        break;
      case AnimeListSortBy.startAirDate:
        return buildAnimeStartAir(context, index, anime);
        break;
      case AnimeListSortBy.endAirDate:
        return buildAnimeEndAir(context, index, anime);
        break;
    }
    return SizedBox();
  }
}
