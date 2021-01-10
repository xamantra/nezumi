import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../mixins/index.dart';
import '../../index.dart';
import 'tabs/index.dart';

class TopAnimePage extends StatefulWidget {
  TopAnimePage({Key key}) : super(key: key);

  @override
  _TopAnimePageState createState() => _TopAnimePageState();
}

class _TopAnimePageState extends State<TopAnimePage> with CoreStateMixin, SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
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
              Container(
                height: sy(42),
                width: width,
                color: AppTheme.of(context).primaryBackground,
                child: TabBar(
                  controller: tabController,
                  labelStyle: TextStyle(
                    fontSize: sy(8),
                  ),
                  indicatorWeight: 3,
                  indicatorColor: AppTheme.of(context).primary,
                  tabs: [
                    Tab(
                      text: 'MAL Rankings',
                      icon: Icon(CustomIcons.award, size: sy(13)),
                    ),
                    Tab(
                      text: 'Yearly Rankings',
                      icon: Icon(Icons.calendar_today_sharp, size: sy(13)),
                    ),
                  ],
                ),
              ),
              /* Tabs */
            ],
          ),
        );
      },
    );
  }
}
