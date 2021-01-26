import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../mixins/index.dart';
import '../app-theme.dart';
import '../index.dart';
import 'anime-list/index.dart';
import 'history/index.dart';
import 'settings/index.dart';
import 'top-anime/index.dart';

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
                          DrawerItem(
                            icon: CustomIcons.th,
                            text: 'Anime List',
                            onPressed: () {
                              Navigator.pop(context);
                              gotoPage(context, AnimeListPage());
                            },
                          ),
                          DrawerItem(
                            icon: CustomIcons.award,
                            text: 'Top Anime',
                            onPressed: () {
                              Navigator.pop(context);
                              gotoPage(context, TopAnimePage());
                            },
                          ),
                          DrawerItem(
                            icon: CustomIcons.history,
                            text: 'History',
                            onPressed: () {
                              Navigator.pop(context);
                              gotoPage(context, History());
                            },
                          ),
                          DrawerItem(icon: Icons.account_tree, text: 'Seasonals'),
                          DrawerItem(icon: Icons.error, text: 'List Errors'),
                          DrawerItem(icon: CustomIcons.tags, text: 'Recommendations'),
                          Divider(height: 24, color: Colors.white.withOpacity(0.15)),
                          DividerSectionHeader(text: 'Manga'),
                          DrawerItem(icon: CustomIcons.book, text: 'Manga List'),
                          DrawerItem(icon: CustomIcons.award, text: 'Top Manga'),
                          DrawerItem(icon: CustomIcons.history_1, text: 'History'),
                          DrawerItem(icon: Icons.error, text: 'List Errors'),
                          DrawerItem(icon: CustomIcons.tag_empty, text: 'Recommendations'),
                          Divider(height: 24, color: Colors.white.withOpacity(0.15)),
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
    @required this.icon,
    @required this.text,
    this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return SizedButton(
          height: sy(36),
          width: width,
          onPressed: onPressed ?? () {},
          child: Container(
            padding: EdgeInsets.all(sy(12)),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: sy(10),
                  color: AppTheme.of(context).text2,
                ),
                SizedBox(width: sy(16)),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: sy(10),
                    color: AppTheme.of(context).text2,
                    fontWeight: FontWeight.w500,
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
