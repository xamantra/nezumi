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
    tabController = TabController(initialIndex: 0, length: 6, vsync: this);
    currentTab = tabController.index;
    tabController.addListener(() {
      if (currentTab != tabController.index) {
        currentTab = tabController.index;
        app.triggerRebuild();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var c = animeStats.controller;
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
                              statList: c.getGenreStatItems(),
                              sortBy: animeStats.sortBy,
                            ),
                            AnimeStatPage(
                              statList: c.getSourceMaterialStatItems(),
                              sortBy: animeStats.sortBy,
                            ),
                            AnimeStatPage(
                              statList: c.getStudioStatItems(),
                              sortBy: animeStats.sortBy,
                              normalizeLabel: false,
                            ),
                            AnimeStatPage(
                              statList: c.getYearStatItems(),
                              sortBy: animeStats.sortBy,
                            ),
                            AnimeStatPage(
                              statList: c.getSeasonStatItems(),
                              sortBy: animeStats.sortBy,
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
