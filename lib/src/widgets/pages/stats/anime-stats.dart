import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../components/anime-stats/index.dart';
import '../../../components/app/index.dart';
import '../../../data/types/index.dart';
import '../../../mixins/index.dart';
import '../../index.dart';
import 'index.dart';

class AnimeStatistics extends StatefulWidget {
  const AnimeStatistics({Key key}) : super(key: key);

  @override
  _AnimeStatisticsState createState() => _AnimeStatisticsState();
}

class _AnimeStatisticsState extends State<AnimeStatistics> with CoreStateMixin, SingleTickerProviderStateMixin {
  TabController tabController;
  int currentTab;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tabController = TabController(initialIndex: 0, length: 8, vsync: this);
    currentTab = tabController.index;
    tabController.addListener(() {
      if (currentTab != tabController.index) {
        currentTab = tabController.index;
        app.triggerRebuild();
      }
    });
    animeStats.controller.loadAllStats();
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Container(
          height: height,
          width: width,
          color: AppTheme.of(context).primary,
          child: SafeArea(
            child: Column(
              children: [
                MomentumBuilder(
                  controllers: [AnimeStatsController],
                  builder: (context, snapshot) {
                    IconData orderByIcon;
                    IconData sortByIcon;
                    String orderBy;
                    switch (animeStats.orderBy) {
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
                    return Toolbar(
                      height: sy(42),
                      leadingIcon: Icons.menu,
                      title: 'Anime Statistics',
                      actions: [
                        ToolbarAction(
                          icon: orderByIcon,
                          size: sy(32),
                          iconSize: sy(13),
                          tooltip: orderBy,
                          onPressed: () {
                            animeStats.controller.toggleAnimeStatOrderBy();
                          },
                        ),
                        AnimeStatSortMenu(
                          value: animeStats.sortBy,
                          iconSize: sy(10),
                          orderByIcon: sortByIcon,
                          onChanged: (sortBy) {
                            animeStats.controller.changeAnimeStatSortBy(sortBy);
                          },
                        ),
                      ],
                      leadingAction: () {
                        Scaffold.of(context).openDrawer();
                      },
                    );
                  },
                ),
                Container(
                  height: sy(30),
                  width: width,
                  color: AppTheme.of(context).primary,
                  padding: EdgeInsets.symmetric(horizontal: sy(8)),
                  child: MomentumBuilder(
                    controllers: [AppController],
                    builder: (context, snapshot) {
                      return TabBar(
                        controller: tabController,
                        isScrollable: true,
                        labelColor: Colors.white,
                        labelPadding: EdgeInsets.symmetric(horizontal: sy(8)),
                        indicatorPadding: EdgeInsets.zero,
                        indicatorColor: Colors.transparent,
                        physics: BouncingScrollPhysics(),
                        tabs: [
                          MyListTabItem(label: 'Overall', active: currentTab == 0),
                          MyListTabItem(label: 'Genre', active: currentTab == 1),
                          MyListTabItem(label: 'Source Material', active: currentTab == 2),
                          MyListTabItem(label: 'Studio', active: currentTab == 3),
                          MyListTabItem(label: 'Year', active: currentTab == 4),
                          MyListTabItem(label: 'Season', active: currentTab == 5),
                          MyListTabItem(label: 'Format', active: currentTab == 6),
                          MyListTabItem(label: 'Content Rating', active: currentTab == 7),
                        ],
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    color: AppTheme.of(context).primaryBackground,
                    child: MomentumBuilder(
                      controllers: [AnimeStatsController],
                      builder: (context, snapshot) {
                        return TabBarView(
                          controller: tabController,
                          children: [
                            SizedBox(),
                            AnimeStatPage(
                              statList: animeStats.genreStatItems,
                              sortBy: animeStats.sortBy,
                            ),
                            AnimeStatPage(
                              statList: animeStats.sourceMaterialStatItems,
                              sortBy: animeStats.sortBy,
                            ),
                            AnimeStatPage(
                              statList: animeStats.studioStatItems,
                              sortBy: animeStats.sortBy,
                              normalizeLabel: false,
                            ),
                            AnimeStatPage(
                              statList: animeStats.yearStatItems,
                              sortBy: animeStats.sortBy,
                            ),
                            AnimeStatPage(
                              statList: animeStats.seasonStatItems,
                              sortBy: animeStats.sortBy,
                            ),
                            AnimeStatPage(
                              statList: animeStats.formatItems,
                              sortBy: animeStats.sortBy,
                              labeler: (_) => _.toUpperCase(),
                            ),
                            AnimeStatPage(
                              statList: animeStats.ratingItems,
                              sortBy: animeStats.sortBy,
                              labeler: (_) => _.toUpperCase(),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
