import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../main.dart';
import '../../_mconfig/index.dart';
import '../../mixins/index.dart';
import '../app-theme.dart';
import '../index.dart';
import 'anime-list/tabs/index.dart';
import 'history/index.dart';
import 'settings/index.dart';
import 'top-anime/tabs/index.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> with CoreStateMixin {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Container(
          height: height,
          width: sy(180),
          color: AppTheme.of(context).primaryBackground,
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: sy(42),
                      padding: EdgeInsets.all(sy(8)),
                      color: AppTheme.of(context).primaryBackground,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Nezumi',
                          style: TextStyle(
                            fontSize: sy(14),
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    SizedButton(
                      height: sy(36),
                      width: sy(36),
                      radius: 100,
                      child: Icon(
                        Icons.person,
                        size: sy(14),
                        color: AppTheme.of(context).accent,
                      ),
                      onPressed: () {},
                    ),
                    SizedButton(
                      height: sy(36),
                      width: sy(36),
                      radius: 100,
                      child: Icon(
                        Icons.settings,
                        size: sy(14),
                        color: AppTheme.of(context).accent,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        gotoPage(context, AppSettingsPage());
                      },
                    ),
                  ],
                ),
                Divider(height: 1, color: Colors.white.withOpacity(0.15)),
                Expanded(
                  child: Container(
                    width: width,
                    color: AppTheme.of(context).primaryBackground,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DividerSectionHeader(text: 'Anime'),
                          DrawerItem(text: 'My List', page: MyListTabPage()),
                          DrawerItem(text: 'Search', page: AnimeSearchTabPage()),
                          DrawerItem(text: 'Filter', page: AnimeFilterTab()),
                          DrawerItem(text: 'Rankings', page: MalAnimeRankingPage()),
                          DrawerItem(text: 'Yearly', page: YearlyAnimeRankingPage()),
                          DrawerItem(text: 'History', page: History()),
                          DrawerItem(text: 'Seasonals'),
                          DrawerItem(text: 'List Errors'),
                          DrawerItem(text: 'Recommendations'),
                          Divider(height: 24, color: Colors.white.withOpacity(0.15)),
                          DividerSectionHeader(text: 'Manga'),
                          DrawerItem(text: 'Manga List'),
                          DrawerItem(text: 'Top Manga'),
                          DrawerItem(text: 'History'),
                          DrawerItem(text: 'List Errors'),
                          DrawerItem(text: 'Recommendations'),
                          Divider(height: 24, color: Colors.white.withOpacity(0.15)),
                          DrawerItem(
                            text: 'Logout',
                            color: Colors.red,
                            customAction: () async {
                              await clearStorage();
                              Momentum.restart(context, momentum());
                            },
                          ),
                        ],
                      ),
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

class DividerSectionHeader extends StatelessWidget {
  const DividerSectionHeader({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Padding(
          padding: EdgeInsets.only(left: sy(8), top: sy(8)),
          child: Text(
            text,
            style: TextStyle(
              fontSize: sy(9),
              color: Colors.white.withOpacity(0.5),
            ),
          ),
        );
      },
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    Key key,
    @required this.text,
    this.page,
    this.color,
    this.customAction,
  }) : super(key: key);

  final String text;
  final Widget page;
  final Color color;
  final void Function() customAction;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return SizedButton(
          height: sy(36),
          width: width,
          onPressed: customAction ??
              () {
                if (page != null) {
                  Navigator.pop(context);
                  gotoPage(context, page);
                }
              },
          child: Container(
            padding: EdgeInsets.all(sy(12)),
            child: Row(
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontSize: sy(10),
                    color: color ?? AppTheme.of(context).text2,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.start,
                ),
                Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}
