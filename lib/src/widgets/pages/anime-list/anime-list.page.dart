import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../index.dart';
import 'tabs/index.dart';

class AnimeListPage extends StatefulWidget {
  const AnimeListPage({Key key}) : super(key: key);

  @override
  _AnimeListPageState createState() => _AnimeListPageState();
}

class _AnimeListPageState extends State<AnimeListPage> with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Container(
          height: height,
          width: width,
          color: AppTheme.of(context).secondaryBackground,
          child: Column(
            children: [
              /* Pages Container */
              Expanded(
                child: Container(
                  height: height,
                  width: width,
                  color: AppTheme.of(context).secondaryBackground,
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      MyListTabPage(),
                      SizedBox(),
                      SizedBox(),
                      SizedBox(),
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
                      text: 'My List',
                      icon: Icon(CustomIcons.th, size: sy(9)),
                    ),
                    Tab(
                      text: 'Search',
                      icon: Icon(Icons.search, size: sy(13)),
                    ),
                    Tab(
                      text: 'Filter',
                      icon: Icon(Icons.filter_list, size: sy(13)),
                    ),
                    Tab(
                      text: 'Stats',
                      icon: Icon(Icons.trending_up, size: sy(13)),
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
