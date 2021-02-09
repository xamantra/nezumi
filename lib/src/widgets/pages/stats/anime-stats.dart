import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../components/app/index.dart';
import '../../../mixins/index.dart';
import '../../index.dart';
import 'stat-pages/genre.dart';

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
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Container(
          height: height,
          width: width,
          color: AppTheme.of(context).primary,
          child: SafeArea(
            child: Column(
              children: [
                Toolbar(
                  height: sy(42),
                  leadingIcon: Icons.menu,
                  title: 'Anime Statistics',
                  actions: [],
                  leadingAction: () {
                    Scaffold.of(context).openDrawer();
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
                          MyListTabItem(label: 'Specialized', active: currentTab == 2),
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
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        SizedBox(),
                        AnimeStatGenre(),
                        SizedBox(),
                        SizedBox(),
                        SizedBox(),
                        SizedBox(),
                      ],
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