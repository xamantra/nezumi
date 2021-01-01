import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../../mixins/index.dart';
import '../../../../modules/anime-search/index.dart';
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
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
                  actions: [
                    // TODO: grid and list view mode switcher
                    ToolbarAction(icon: Icons.view_list),
                  ],
                  leadingAction: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sy(8)),
                  child: Stack(
                    children: [
                      Center(
                        child: SizedBox(
                          width: sy(150),
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
                              animeSearch.update(query: query);
                            },
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: SizedButton(
                          height: sy(24),
                          width: sy(24),
                          radius: 100,
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: sy(14),
                          ),
                          onPressed: () {
                            searchInputController.clear();
                            searchInputController.clearComposing();
                            animeSearch.update(query: '');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                MomentumBuilder(
                  controllers: [AnimeSearchController],
                  builder: (context, snapshot) {
                    var list = mal.userAnimeList?.getByStatus('all');
                    if (animeSearch.query != null) {
                      list = list.where((x) => x.searchMatch(animeSearch.query)).toList();
                    }

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
                          MyListTabItem(label: 'My List Results', count: list.length),
                          MyListTabItem(label: 'MAL Results', count: 0),
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
                            AnimeListView(status: 'all', search: animeSearch.query),
                            SizedBox(),
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
