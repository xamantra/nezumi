import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../components/anime-top/index.dart';
import '../../../components/app/index.dart';
import '../../../mixins/index.dart';
import '../../index.dart';
import '../../items/index.dart';
import 'tabs/index.dart';

class TopAnimePage extends StatefulWidget {
  TopAnimePage({Key key}) : super(key: key);

  @override
  _TopAnimePageState createState() => _TopAnimePageState();
}

class _TopAnimePageState extends State<TopAnimePage> with CoreStateMixin, SingleTickerProviderStateMixin {
  TabController tabController;

  int currentTab;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tabController = TabController(length: 2, vsync: this);
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
      onWillPop: () async {
        if (animeTop.fullscreen) {
          animeTop.controller.toggleFullscreen();
        }
        return false;
      },
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
                        MalAnimeRankingPage(),
                        YearlyAnimeRankingPage(),
                      ],
                    ),
                  ),
                ),
                /* Pages Container */

                /* Tabs */
                MomentumBuilder(
                  controllers: [AnimeTopController, AppController],
                  builder: (context, snapshot) {
                    if (animeTop.fullscreen) {
                      return SizedBox();
                    }
                    return Container(
                      height: sy(32),
                      width: width,
                      color: AppTheme.of(context).primaryBackground,
                      child: TabBar(
                        controller: tabController,
                        labelStyle: TextStyle(
                          fontSize: sy(8),
                        ),
                        indicatorWeight: 3,
                        labelColor: Colors.white,
                        labelPadding: EdgeInsets.symmetric(horizontal: sy(8)),
                        indicatorPadding: EdgeInsets.zero,
                        indicatorColor: Colors.transparent,
                        physics: BouncingScrollPhysics(),
                        tabs: [
                          TabItemBottom(
                            active: currentTab == 0,
                            icon: CustomIcons.award,
                            iconSize: sy(12),
                            label: 'MAL Rankings',
                          ),
                          TabItemBottom(
                            active: currentTab == 1,
                            icon: Icons.calendar_today_sharp,
                            label: 'Yearly Rankings',
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
