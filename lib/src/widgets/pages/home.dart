import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../modules/my_anime_list/index.dart';
import '../index.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  final RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'MyAnimeList - History',
              style: TextStyle(
                fontSize: sy(12),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          body: MomentumBuilder(
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
        );
      },
    );
  }
}
