import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../components/app/index.dart';
import '../../../mixins/index.dart';
import '../../index.dart';
import '../../items/index.dart';
import 'tabs/index.dart';

class AnimeListPage extends StatefulWidget {
  const AnimeListPage({Key key}) : super(key: key);

  @override
  _AnimeListPageState createState() => _AnimeListPageState();
}

class _AnimeListPageState extends State<AnimeListPage> with SingleTickerProviderStateMixin, CoreStateMixin {
  TabController tabController;

  int currentTab;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tabController = TabController(length: 4, vsync: this);
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
    return WillPopScope(
      onWillPop: () async => false,
      child: RelativeBuilder(
        builder: (context, height, width, sy, sx) {
          return Container(
            height: height,
            width: width,
            color: AppTheme.of(context).primaryBackground,
            child: Column(
              children: [
                /* Pages Container */
                Expanded(
                  child: Container(
                    height: height,
                    width: width,
                    color: AppTheme.of(context).primaryBackground,
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        MyListTabPage(),
                        AnimeSearchTabPage(),
                        AnimeFilterTab(),
                        SizedBox(), // TODO: anime stats page (MAL default stats, by year, by season, by genre)
                      ],
                    ),
                  ),
                ),
                /* Pages Container */

                /* Tabs */
                MomentumBuilder(
                  controllers: [AppController],
                  builder: (context, snapshot) {
                    return Container(
                      height: sy(32),
                      width: width,
                      color: AppTheme.of(context).primaryBackground,
                      child: TabBar(
                        controller: tabController,
                        labelStyle: TextStyle(
                          fontSize: sy(8),
                        ),
                        indicatorWeight: 0,
                        indicatorColor: AppTheme.of(context).primary,
                        indicator: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        tabs: [
                          TabItemBottom(
                            active: currentTab == 0,
                            icon: CustomIcons.th,
                            iconSize: sy(10),
                            label: 'My List',
                          ),
                          TabItemBottom(
                            active: currentTab == 1,
                            icon: Icons.search,
                            label: 'Search',
                          ),
                          TabItemBottom(
                            active: currentTab == 2,
                            icon: Icons.filter_list,
                            label: 'Filter',
                          ),
                          TabItemBottom(
                            active: currentTab == 3,
                            icon: Icons.trending_up,
                            label: 'Stats',
                          ),
                        ],
                      ),
                    );
                  },
                ),
                /* Tabs */
              ],
            ),
          );
        },
      ),
    );
  }
}
