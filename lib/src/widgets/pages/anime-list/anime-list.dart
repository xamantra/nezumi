import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../mixins/index.dart';
import '../../../modules/my_anime_list/index.dart';
import '../../../utils/index.dart';
import '../../app-theme.dart';
import 'index.dart';

class AnimeListPage extends StatefulWidget {
  const AnimeListPage({Key key}) : super(key: key);

  @override
  _AnimeListPageState createState() => _AnimeListPageState();
}

class _AnimeListPageState extends State<AnimeListPage> with TickerProviderStateMixin, CoreStateMixin {
  TabController tabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tabController = TabController(length: 6, vsync: this);
    mal?.controller?.initializeAnimeList();
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Scaffold(
          backgroundColor: AppTheme.of(context).primaryBackground,
          body: SafeArea(
            child: Container(
              height: height,
              width: width,
              color: AppTheme.of(context).primaryBackground,
              padding: EdgeInsets.all(sy(6)),
              child: Column(
                children: [
                  TabBar(
                    controller: tabController,
                    isScrollable: true,
                    labelColor: AppTheme.of(context).primary,
                    indicatorColor: AppTheme.of(context).primary,
                    labelStyle: TextStyle(
                      fontSize: sy(9.5),
                      fontWeight: FontWeight.w400,
                    ),
                    physics: BouncingScrollPhysics(),
                    tabs: [
                      Tab(text: 'All'),
                      Tab(text: 'Watching'),
                      Tab(text: 'On Hold'),
                      Tab(text: 'Completed'),
                      Tab(text: 'Planning'),
                      Tab(text: 'Dropped'),
                    ],
                  ),
                  Expanded(
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
