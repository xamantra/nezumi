import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../../components/app/index.dart';
import '../../../../components/my_anime_list/index.dart';
import '../../../../mixins/index.dart';
import '../../../index.dart';
import '../index.dart';

class MyListTabPage extends StatefulWidget {
  const MyListTabPage({Key key}) : super(key: key);

  @override
  _MyListTabPageState createState() => _MyListTabPageState();
}

class _MyListTabPageState extends State<MyListTabPage> with TickerProviderStateMixin, CoreStateMixin {
  TabController tabController;

  int currentTab;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tabController = TabController(initialIndex: 1, length: 6, vsync: this);
    currentTab = tabController.index;
    tabController.addListener(() {
      if (currentTab != tabController.index) {
        currentTab = tabController.index;
        app.triggerRebuild();
      }
    });
    mal?.controller?.initializeAnimeList();
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
                  title: 'Anime List',
                  actions: [
                    ToolbarAction(
                      icon: Icons.refresh,
                      onPressed: () {
                        mal.controller.loadAnimeList();
                      },
                    ),
                    // TODO: grid and list view mode switcher
                    ToolbarAction(icon: Icons.view_list),
                  ],
                  leadingAction: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
                MomentumBuilder(
                  controllers: [MyAnimeListController, AppController],
                  builder: (context, snapshot) {
                    var all = mal.userAnimeList?.getByStatus('all') ?? [];
                    var watching = mal.userAnimeList?.getByStatus('watching') ?? [];
                    var on_hold = mal.userAnimeList?.getByStatus('on_hold') ?? [];
                    var completed = mal.userAnimeList?.getByStatus('completed') ?? [];
                    var plan_to_watch = mal.userAnimeList?.getByStatus('plan_to_watch') ?? [];
                    var dropped = mal.userAnimeList?.getByStatus('dropped') ?? [];

                    return Container(
                      height: sy(30),
                      width: width,
                      color: AppTheme.of(context).primary,
                      child: TabBar(
                        controller: tabController,
                        isScrollable: true,
                        labelColor: Colors.white,
                        labelPadding: EdgeInsets.symmetric(horizontal: sy(8)),
                        indicatorPadding: EdgeInsets.zero,
                        indicatorColor: Colors.transparent,
                        physics: BouncingScrollPhysics(),
                        tabs: [
                          MyListTabItem(label: 'All', active: currentTab == 0, count: all.length),
                          MyListTabItem(label: 'Watching', active: currentTab == 1, count: watching.length),
                          MyListTabItem(label: 'On Hold', active: currentTab == 2, count: on_hold.length),
                          MyListTabItem(label: 'Completed', active: currentTab == 3, count: completed.length),
                          MyListTabItem(label: 'Planning', active: currentTab == 4, count: plan_to_watch.length),
                          MyListTabItem(label: 'Dropped', active: currentTab == 5, count: dropped.length),
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
                        AnimeListView(status: 'all'),
                        AnimeListView(status: 'watching'),
                        AnimeListView(status: 'on_hold'),
                        AnimeListView(status: 'completed'),
                        AnimeListView(status: 'plan_to_watch'),
                        AnimeListView(status: 'dropped'),
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
