import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../../components/anime-top/index.dart';
import '../../../../components/app/index.dart';
import '../../../../mixins/index.dart';
import '../../../builders/index.dart';
import '../../../index.dart';
import '../index.dart';

class MalAnimeRankingPage extends StatefulWidget {
  const MalAnimeRankingPage({Key key}) : super(key: key);

  @override
  _MalAnimeRankingPageState createState() => _MalAnimeRankingPageState();
}

class _MalAnimeRankingPageState extends State<MalAnimeRankingPage> with CoreStateMixin, SingleTickerProviderStateMixin {
  TabController tabController;

  int currentTab;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tabController = TabController(length: 9, vsync: this);
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
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Stack(
          children: [
            Container(
              height: height,
              width: width,
              color: AppTheme.of(context).primary,
            ),
            SafeArea(
              child: Column(
                children: [
                  Toolbar(
                    height: sy(42),
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
                  ),
                  Container(
                    height: sy(30),
                    color: AppTheme.of(context).primary,
                    padding: EdgeInsets.symmetric(horizontal: sy(6)),
                    child: MomentumBuilder(
                      controllers: [AppController],
                      builder: (context, snapshot) {
                        return TabBar(
                          controller: tabController,
                          isScrollable: true,
                          physics: BouncingScrollPhysics(),
                          labelColor: Colors.white,
                          labelPadding: EdgeInsets.symmetric(horizontal: sy(8)),
                          indicatorPadding: EdgeInsets.zero,
                          indicatorColor: Colors.transparent,
                          tabs: [
                            MyListTabItem(label: 'All', active: currentTab == 0),
                            MyListTabItem(label: 'Airing', active: currentTab == 1),
                            MyListTabItem(label: 'Upcoming', active: currentTab == 2),
                            MyListTabItem(label: 'TV Series', active: currentTab == 3),
                            MyListTabItem(label: 'Movies', active: currentTab == 4),
                            MyListTabItem(label: 'OVAs', active: currentTab == 5),
                            MyListTabItem(label: 'Specials', active: currentTab == 6),
                            MyListTabItem(label: 'Popularity', active: currentTab == 7),
                            MyListTabItem(label: 'Favorited', active: currentTab == 8),
                          ],
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: AppTheme.of(context).primaryBackground,
                      child: MomentumBuilder(
                        controllers: [AnimeTopController],
                        builder: (context, snapshot) {
                          return TabBarView(
                            controller: tabController,
                            physics: BouncingScrollPhysics(),
                            children: [
                              AnimeTopListView(
                                index: 0,
                                leadBuilder: buildAnimeIndexNumber,
                                trailBuilder: buildAnimeScore,
                              ),
                              AnimeTopListView(
                                index: 1,
                                leadBuilder: buildAnimeIndexNumber,
                                trailBuilder: buildAnimeScore,
                              ),
                              AnimeTopListView(
                                index: 2,
                                leadBuilder: buildAnimeIndexNumber,
                                trailBuilder: buildAnimePopularity,
                              ),
                              AnimeTopListView(
                                index: 3,
                                leadBuilder: buildAnimeIndexNumber,
                                trailBuilder: buildAnimeScore,
                              ),
                              AnimeTopListView(
                                index: 4,
                                leadBuilder: buildAnimeIndexNumber,
                                trailBuilder: buildAnimeScore,
                              ),
                              AnimeTopListView(
                                index: 5,
                                leadBuilder: buildAnimeIndexNumber,
                                trailBuilder: buildAnimeScore,
                              ),
                              AnimeTopListView(
                                index: 6,
                                leadBuilder: buildAnimeIndexNumber,
                                trailBuilder: buildAnimeScore,
                              ),
                              AnimeTopListView(
                                index: 7,
                                leadBuilder: buildAnimeIndexNumber,
                                trailBuilder: buildAnimePopularity,
                              ),
                              AnimeTopListView(
                                index: 8,
                                leadBuilder: buildAnimeIndexNumber,
                                trailBuilder: buildAnimeFavorites,
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
          ],
        );
      },
    );
  }
}
