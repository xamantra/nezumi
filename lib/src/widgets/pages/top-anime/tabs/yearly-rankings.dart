import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../../components/anime-top/index.dart';
import '../../../../data/index.dart';
import '../../../../data/types/index.dart';
import '../../../../mixins/index.dart';
import '../../../../utils/index.dart';
import '../../../builders/index.dart';
import '../../../index.dart';
import '../index.dart';
import 'widgets/index.dart';

class YearlyAnimeRankingPage extends StatefulWidget {
  const YearlyAnimeRankingPage({Key key}) : super(key: key);

  @override
  _YearlyAnimeRankingPageState createState() => _YearlyAnimeRankingPageState();
}

class _YearlyAnimeRankingPageState extends State<YearlyAnimeRankingPage> with CoreStateMixin, SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tabController = TabController(length: 9, vsync: this);
    animeTop.controller.loadYearRankings();
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return SafeArea(
          child: Column(
            children: [
              MomentumBuilder(
                controllers: [AnimeTopController],
                builder: (context, snapshot) {
                  if (animeTop.fullscreen) {
                    return SizedBox();
                  }
                  return Toolbar(
                    height: sy(33),
                    leadingIcon: Icons.menu,
                    title: 'Top Anime',
                    actions: [
                      ToolbarAction(
                        icon: Icons.refresh,
                        onPressed: () {
                          // TODO: refresh active tab.
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
                  String orderBy;
                  switch (animeTop.yearlyRankingOrderBy) {
                    case OrderBy.ascending:
                      orderByIcon = Icons.arrow_upward;
                      orderBy = 'Ascending';
                      break;
                    case OrderBy.descending:
                      orderByIcon = Icons.arrow_downward;
                      orderBy = 'Descending';
                      break;
                  }
                  return RelativeBuilder(
                    scale: animeTop.fullscreen ? 0.8 : 1,
                    builder: (context, height, width, sy, sx) {
                      return Container(
                        color: animeTop.fullscreen ? Colors.transparent : AppTheme.of(context).primary,
                        padding: EdgeInsets.symmetric(horizontal: sy(6)),
                        height: animeTop.fullscreen ? sy(32) : sy(42),
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
                              ),
                              onPressed: () {
                                animeTop.controller.prevYear();
                              },
                            ),
                            Text(
                              '${animeTop.selectedYear}',
                              style: TextStyle(
                                fontSize: sy(11),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedButton(
                              height: sy(32),
                              width: sy(32),
                              radius: 100,
                              enabled: !animeTop.loadingYearlyRankings,
                              child: Icon(
                                Icons.chevron_right,
                              ),
                              onPressed: () {
                                animeTop.controller.nextYear();
                              },
                            ),
                            ToolbarAction(
                              icon: orderByIcon,
                              tooltip: orderBy,
                              onPressed: () {
                                animeTop.controller.toggleOrderBy();
                              },
                            ),
                            YearlyAnimeRankingSortMenu(
                              value: animeTop.yearlyRankingSortBy,
                              onChanged: (sortBy) {
                                animeTop.controller.changeSortBy(sortBy);
                              },
                            ),
                            ToolbarAction(
                              icon: Icons.remove_red_eye,
                              tooltip: 'View excluded',
                              onPressed: () {
                                push(
                                  context,
                                  AnimeTopListExlcudedView(
                                    leadBuilder: buildAnimeGlobalItemIndexNumber,
                                    trailBuilder: _buildTrailWidget,
                                  ),
                                );
                              },
                            ),
                            ToolbarAction(
                              icon: animeTop.fullscreen ? Icons.fullscreen_exit_sharp : Icons.fullscreen_sharp,
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
                        leadBuilder: buildAnimeGlobalItemIndexNumber,
                        trailBuilder: _buildTrailWidget,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTrailWidget(BuildContext context, int index, AnimeDataItem anime) {
    switch (animeTop.yearlyRankingSortBy) {
      case AnimeSortBy.title:
        break;
      case AnimeSortBy.score:
        return buildAnimeGlobalItemScore(context, index, anime);
        break;
      case AnimeSortBy.member:
        return buildAnimeGlobalItemPopularity(context, index, anime);
        break;
      case AnimeSortBy.scoringMember:
        return buildAnimeGlobalItemScoringUsers(context, index, anime);
        break;
      case AnimeSortBy.totalDuraton:
        return buildAnimeGlobalItemTotalDuration(context, index, anime);
        break;
    }
    return SizedBox();
  }
}
