import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../../components/anime-filter/index.dart';
import '../../../../components/app/index.dart';
import '../../../../mixins/index.dart';
import '../../../index.dart';
import 'anime-filter-widgets/index.dart';

class AnimeFilterTab extends StatefulWidget {
  const AnimeFilterTab({Key key}) : super(key: key);

  @override
  _AnimeFilterTabState createState() => _AnimeFilterTabState();
}

class _AnimeFilterTabState extends State<AnimeFilterTab> with SingleTickerProviderStateMixin, CoreStateMixin {
  TabController tabController;

  int currentTab;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
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
                  title: 'Anime Filter',
                  actions: [],
                  leadingAction: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
                MomentumBuilder(
                  controllers: [AnimeFilterController, AppController],
                  builder: (context, snapshot) {
                    return Container(
                      height: sy(30),
                      width: width,
                      color: AppTheme.of(context).primary,
                      padding: EdgeInsets.symmetric(horizontal: sy(8)),
                      child: TabBar(
                        controller: tabController,
                        labelColor: Colors.white,
                        labelPadding: EdgeInsets.symmetric(horizontal: sy(8)),
                        indicatorPadding: EdgeInsets.zero,
                        indicatorColor: Colors.transparent,
                        physics: BouncingScrollPhysics(),
                        tabs: [
                          MyListTabItem(
                            label: 'Filters',
                            active: currentTab == 0,
                            count: animeFilter.animeFilters.length,
                          ),
                          MyListTabItem(
                            label: 'Results',
                            active: currentTab == 1,
                            count: animeFilter.results.length,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Expanded(
                  child: Container(
                    color: AppTheme.of(context).primaryBackground,
                    child: TabBarView(
                      controller: tabController,
                      physics: BouncingScrollPhysics(),
                      children: [
                        AnimeFilterList(),
                        AnimeFilterResultView(),
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
