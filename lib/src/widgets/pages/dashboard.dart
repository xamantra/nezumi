import 'package:flutter/material.dart';
import 'package:nezumi/src/widgets/app-theme.dart';
import 'package:relative_scale/relative_scale.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RelativeBuilder(
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
                        SizedBox(),
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
                        text: 'Anime',
                        icon: Icon(Icons.tv_sharp, size: sy(13)),
                      ),
                      Tab(
                        text: 'Manga',
                        icon: Icon(Icons.book_rounded, size: sy(13)),
                      ),
                      Tab(
                        text: 'History',
                        icon: Icon(Icons.history, size: sy(13)),
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
      ),
    );
  }
}
