import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../../components/anime-search/index.dart';
import '../../../../components/app/index.dart';
import '../../../../mixins/index.dart';
import '../../../index.dart';
import '../index.dart';

class AnimeSearchTabPage extends StatefulWidget {
  const AnimeSearchTabPage({Key key}) : super(key: key);

  @override
  _AnimeSearchTabPageState createState() => _AnimeSearchTabPageState();
}

class _AnimeSearchTabPageState extends State<AnimeSearchTabPage> with TickerProviderStateMixin, CoreStateMixin {
  TabController tabController;
  TextEditingController searchInputController;

  int currentTab;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    currentTab = tabController.index;
    tabController.addListener(() {
      if (currentTab != tabController.index) {
        currentTab = tabController.index;
        app.triggerRebuild();
      }
    });
    mal?.controller?.initializeAnimeList();
    searchInputController = TextEditingController(text: animeSearch.query);
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        var underlineInputBorder = InputBorder.none;
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
                  title: 'Anime Search',
                  titleWidget: Center(
                    child: SizedBox(
                      width: width,
                      child: TextFormField(
                        controller: searchInputController,
                        decoration: InputDecoration(
                          isDense: true,
                          border: underlineInputBorder,
                          enabledBorder: underlineInputBorder,
                          focusedBorder: underlineInputBorder,
                          hintText: 'Type here to search...',
                        ),
                        style: TextStyle(
                          color: AppTheme.of(context).text1,
                          fontSize: sy(13),
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        onChanged: (query) {
                          animeSearch.controller.search(query);
                        },
                        onFieldSubmitted: (query) {
                          animeSearch.controller.submitMALSearch();
                        },
                      ),
                    ),
                  ),
                  actions: [
                    ToolbarAction(
                      icon: Icons.close,
                      onPressed: () {
                        searchInputController.clear();
                        searchInputController.clearComposing();
                        animeSearch.controller.search('');
                        animeSearch.controller.submitMALSearch();
                      },
                    ),
                  ],
                  leadingAction: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
                MomentumBuilder(
                  controllers: [AnimeSearchController, AppController],
                  builder: (context, snapshot) {
                    var list = animeSearch?.listResults ?? [];
                    var malResults = animeSearch?.results ?? [];

                    return Container(
                      height: sy(30),
                      width: width,
                      color: AppTheme.of(context).primary,
                      padding: EdgeInsets.symmetric(horizontal: sy(8)),
                      child: TabBar(
                        controller: tabController,
                        labelColor: Colors.white,
                        labelPadding: EdgeInsets.symmetric(horizontal: sy(8)),
                        indicatorPadding: EdgeInsets.zero,
                        indicatorColor: Colors.transparent,
                        physics: BouncingScrollPhysics(),
                        tabs: [
                          MyListTabItem(
                            label: 'My List Results',
                            count: list.length,
                            active: currentTab == 0,
                          ),
                          MyListTabItem(
                            label: 'MAL Results',
                            count: malResults.length,
                            active: currentTab == 1,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Expanded(
                  child: Container(
                    color: AppTheme.of(context).primaryBackground,
                    child: MomentumBuilder(
                      controllers: [AnimeSearchController],
                      builder: (context, snapshot) {
                        return TabBarView(
                          controller: tabController,
                          physics: BouncingScrollPhysics(),
                          children: [
                            AnimeSearchListView(isMyListResults: true),
                            AnimeSearchListView(isMyListResults: false),
                          ],
                        );
                      },
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
