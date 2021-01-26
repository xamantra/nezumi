import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../components/my_anime_list/index.dart';
import '../../../components/settings/index.dart';
import '../../../mixins/index.dart';
import '../../../utils/index.dart';
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
    return WillPopScope(
      onWillPop: () async => false,
      child: RelativeBuilder(
        builder: (context, height, width, sy, sx) {
          return Scaffold(
            backgroundColor: AppTheme.of(context).primary,
            appBar: Toolbar(
              height: sy(36),
              leadingIcon: Icons.menu,
              title: 'Watch History',
              actions: [
                ToolbarAction(
                  icon: Icons.settings,
                  onPressed: () {
                    dialog(context, HistoryAnimeSettings());
                  },
                ),
              ],
              leadingAction: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            body: SafeArea(
              child: MomentumBuilder(
                controllers: [MyAnimeListController, SettingsController],
                builder: (context, snapshot) {
                  var loading = mal.loading;

                  if (loading) {
                    return Loader();
                  }

                  var historyGroup = mal?.controller?.getGroupedHistoryData();
                  var requiredHoursMet = (mal?.controller?.requiredHoursMet() ?? false);
                  return Container(
                    color: AppTheme.of(context).primaryBackground,
                    height: height,
                    width: width,
                    child: Column(
                      children: [
                        Expanded(
                          child: SmartRefresher(
                            physics: BouncingScrollPhysics(),
                            enablePullDown: true,
                            controller: refreshController,
                            onRefresh: () {
                              mal.controller.loadAnimeHistory();
                            },
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    !requiredHoursMet ? Icons.error_outline : Icons.check_circle,
                                    size: sy(10),
                                    color: !requiredHoursMet ? Colors.red : Colors.green,
                                  ),
                                  SizedBox(width: sy(2)),
                                  StatItem(
                                    value: mal?.controller?.getHoursPerDay()?.toString() ?? '--',
                                    label: 'Hrs/day',
                                    valueColor: requiredHoursMet ? Colors.green : Colors.red,
                                  ),
                                ],
                              ),
                              StatItem(
                                value: mal?.controller?.getMinutesPerEp()?.toString() ?? '--',
                                label: 'Mins/ep',
                                valueColor: AppTheme.of(context).accent,
                              ),
                              StatItem(
                                value: mal?.controller?.getEpisodesPerDay()?.toString() ?? '--',
                                label: 'Eps/day',
                                valueColor: AppTheme.of(context).accent,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
