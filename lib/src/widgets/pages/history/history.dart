import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../mixins/index.dart';
import '../../../modules/my_anime_list/index.dart';
import '../../index.dart';
import 'index.dart';

class History extends StatefulWidget {
  const History({Key key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> with SingleTickerProviderStateMixin, CoreStateMixin {
  final RefreshController refreshController = RefreshController(initialRefresh: false);
  TabController tabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tabController ??= TabController(length: 2, vsync: this);
    mal?.controller?.initializeAnimeHistory();
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Scaffold(
          backgroundColor: AppTheme.of(context).primary,
          appBar: Toolbar(
            height: sy(36),
            title: 'History',
            actions: [
              ToolbarAction(icon: Icons.settings),
              ToolbarAction(icon: Icons.more_vert),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  height: sy(36),
                  width: width,
                  color: AppTheme.of(context).primary,
                  child: TabBar(
                    controller: tabController,
                    labelStyle: TextStyle(fontSize: sy(11)),
                    indicatorColor: Colors.white,
                    tabs: [
                      Tab(text: 'Anime'),
                      Tab(text: 'Manga'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      MomentumBuilder(
                        controllers: [MyAnimeListController],
                        builder: (context, snapshot) {
                          var loading = mal.loading;
                          var historyGroup = mal?.controller?.getGroupedHistoryData();
                          return Column(
                            children: [
                              Expanded(
                                child: loading
                                    ? Loader()
                                    : Container(
                                        color: AppTheme.of(context).secondaryBackground,
                                        height: height,
                                        width: width,
                                        child: Column(
                                          children: [
                                            SafeArea(child: SizedBox()),
                                            Expanded(
                                              child: SmartRefresher(
                                                enablePullDown: true,
                                                controller: refreshController,
                                                onRefresh: () {
                                                  mal.controller.loadAnimeHistory();
                                                },
                                                child: ListView.builder(
                                                  itemCount: historyGroup.length,
                                                  itemBuilder: (_, i) {
                                                    return HistoryGroup(historyGroupData: historyGroup[i]);
                                                  },
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: sy(40),
                                              width: width,
                                              color: AppTheme.of(context).primaryBackground,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  StatItem(
                                                    value: mal?.controller?.getHoursPerDay()?.toString() ?? '--',
                                                    label: 'Hrs/day',
                                                    valueColor: (mal?.controller?.requiredHoursMet() ?? false) ? Colors.green : Colors.red,
                                                  ),
                                                  StatItem(
                                                    value: mal?.controller?.getMinutesPerEp()?.toString() ?? '--',
                                                    label: 'Mins/ep',
                                                    valueColor: (mal?.controller?.requiredMinsMet() ?? false) ? Colors.green : Colors.red,
                                                  ),
                                                  StatItem(
                                                    value: mal?.controller?.getEpisodesPerDay()?.toString() ?? '--',
                                                    label: 'Eps/day',
                                                    valueColor: (mal?.controller?.requiredEpsMet() ?? false) ? Colors.green : Colors.red,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                              ),
                              SizedButton(
                                height: sy(32),
                                width: width,
                                color: AppTheme.of(context).primaryBackground,
                                child: Text(
                                  'FETCH ANIME LIST',
                                  style: TextStyle(
                                    color: AppTheme.of(context).primary,
                                    fontSize: sy(9),
                                  ),
                                ),
                                onPressed: () {
                                  mal?.controller?.loadData();
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      Center(
                        child: Text(
                          'SOON',
                          style: TextStyle(
                            color: AppTheme.of(context).text3,
                          ),
                        ),
                      ),
                    ],
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
