import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../modules/my_anime_list/index.dart';
import '../../utils/index.dart';
import '../index.dart';

class History extends StatefulWidget {
  const History({Key key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> with SingleTickerProviderStateMixin {
  MyAnimeListController malController;
  final RefreshController refreshController = RefreshController(initialRefresh: false);
  TabController tabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tabController ??= TabController(length: 2, vsync: this);
    malController = ctrl<MyAnimeListController>(context);
    malController.initializeAnimeHistory();
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Scaffold(
          backgroundColor: AppTheme.of(context).primaryBackground,
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  height: sy(36),
                  width: width,
                  child: TabBar(
                    controller: tabController,
                    labelStyle: TextStyle(fontSize: sy(11)),
                    indicatorColor: AppTheme.of(context).primary,
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
                          var session = snapshot<MyAnimeListModel>();
                          var loading = session.loading;
                          var historyGroup = session.controller.getGroupedHistoryData();
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
                                                  session.controller.loadAnimeHistory();
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
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '${session.controller.getMinutesPerEp()} ',
                                                        style: TextStyle(
                                                          color: session.controller.requiredMinsMet() ? Colors.green : Colors.red,
                                                          fontSize: sy(9),
                                                          fontWeight: FontWeight.w700,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Minutes per ep'.toUpperCase(),
                                                        style: TextStyle(
                                                          color: AppTheme.of(context).text3,
                                                          fontSize: sy(9),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '${session.controller.getEpisodesPerDay()} ',
                                                        style: TextStyle(
                                                          color: session.controller.requiredEpsMet() ? Colors.green : Colors.red,
                                                          fontSize: sy(9),
                                                          fontWeight: FontWeight.w700,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Episodes per day'.toUpperCase(),
                                                        style: TextStyle(
                                                          color: AppTheme.of(context).text3,
                                                          fontSize: sy(9),
                                                        ),
                                                      ),
                                                    ],
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
                                  session.controller.loadData();
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
