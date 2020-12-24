import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../../mixins/index.dart';
import '../../../../modules/anime-filter/index.dart';
import '../../../index.dart';
import '../index.dart';

class AnimeFilterTab extends StatefulWidget {
  const AnimeFilterTab({Key key}) : super(key: key);

  @override
  _AnimeFilterTabState createState() => _AnimeFilterTabState();
}

class _AnimeFilterTabState extends State<AnimeFilterTab> with SingleTickerProviderStateMixin, CoreStateMixin {
  TabController tabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tabController = TabController(initialIndex: 0, length: 3, vsync: this);
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
                  actions: [
                    // TODO: grid and list view mode switcher
                    ToolbarAction(icon: Icons.view_list),
                  ],
                  leadingAction: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
                MomentumBuilder(
                  controllers: [AnimeFilterController],
                  builder: (context, snapshot) {
                    return Container(
                      width: width,
                      color: AppTheme.of(context).primary,
                      padding: EdgeInsets.symmetric(horizontal: sy(8)),
                      child: TabBar(
                        controller: tabController,
                        labelColor: Colors.white,
                        indicatorColor: Colors.white,
                        physics: BouncingScrollPhysics(),
                        tabs: [
                          MyListTabItem(label: 'Filters', count: 0),
                          MyListTabItem(label: 'Results', count: 0),
                          MyListTabItem(label: 'Result Stats', count: 0),
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
                        SizedBox(), // TODO: filter list page.
                        AnimeFilterListView(),
                        SizedBox(), // TODO: result stats page.
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
