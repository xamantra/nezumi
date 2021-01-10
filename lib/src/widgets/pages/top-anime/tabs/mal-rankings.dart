import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../../components/anime-top/index.dart';
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tabController = TabController(length: 9, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return SafeArea(
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
                color: AppTheme.of(context).primary,
                padding: EdgeInsets.symmetric(horizontal: sy(6)),
                child: TabBar(
                  controller: tabController,
                  isScrollable: true,
                  labelColor: Colors.white,
                  indicatorColor: Colors.white,
                  physics: BouncingScrollPhysics(),
                  tabs: [
                    MyListTabItem(label: 'All'),
                    MyListTabItem(label: 'Airing'),
                    MyListTabItem(label: 'Upcoming'),
                    MyListTabItem(label: 'TV Series'),
                    MyListTabItem(label: 'Movies'),
                    MyListTabItem(label: 'OVAs'),
                    MyListTabItem(label: 'Specials'),
                    MyListTabItem(label: 'Popularity'),
                    MyListTabItem(label: 'Favorited'),
                  ],
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
                            leadBuilder: buildAnimeGlobalItemIndexNumber,
                            trailBuilder: buildAnimeGlobalItemScore,
                          ),
                          AnimeTopListView(
                            index: 1,
                            leadBuilder: buildAnimeGlobalItemIndexNumber,
                            trailBuilder: buildAnimeGlobalItemScore,
                          ),
                          AnimeTopListView(
                            index: 2,
                            leadBuilder: buildAnimeGlobalItemIndexNumber,
                            trailBuilder: buildAnimeGlobalItemPopularity,
                          ),
                          AnimeTopListView(
                            index: 3,
                            leadBuilder: buildAnimeGlobalItemIndexNumber,
                            trailBuilder: buildAnimeGlobalItemScore,
                          ),
                          AnimeTopListView(
                            index: 4,
                            leadBuilder: buildAnimeGlobalItemIndexNumber,
                            trailBuilder: buildAnimeGlobalItemScore,
                          ),
                          AnimeTopListView(
                            index: 5,
                            leadBuilder: buildAnimeGlobalItemIndexNumber,
                            trailBuilder: buildAnimeGlobalItemScore,
                          ),
                          AnimeTopListView(
                            index: 6,
                            leadBuilder: buildAnimeGlobalItemIndexNumber,
                            trailBuilder: buildAnimeGlobalItemScore,
                          ),
                          AnimeTopListView(
                            index: 7,
                            leadBuilder: buildAnimeGlobalItemIndexNumber,
                            trailBuilder: buildAnimeGlobalItemPopularity,
                          ),
                          AnimeTopListView(
                            index: 8,
                            leadBuilder: buildAnimeGlobalItemIndexNumber,
                            trailBuilder: buildAnimeGlobalItemFavorites,
                          ),
                        ],
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
}
