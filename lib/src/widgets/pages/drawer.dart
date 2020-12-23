import 'package:flutter/material.dart';
import 'package:nezumi/src/widgets/app-theme.dart';
import 'package:nezumi/src/widgets/index.dart';
import 'package:relative_scale/relative_scale.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Container(
          height: height,
          width: sy(180),
          color: AppTheme.of(context).secondaryBackground,
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  height: sy(42),
                  width: width,
                  padding: EdgeInsets.all(sy(8)),
                  color: AppTheme.of(context).secondaryBackground,
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
                Divider(height: 1, color: Colors.white.withOpacity(0.15)),
                Expanded(
                  child: Container(
                    width: width,
                    color: AppTheme.of(context).secondaryBackground,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DividerSectionHeader(text: 'Anime'),
                          DrawerItem(icon: CustomIcons.th, text: 'Anime List'),
                          DrawerItem(icon: CustomIcons.award, text: 'Top Anime'),
                          DrawerItem(icon: CustomIcons.history, text: 'History'),
                          DrawerItem(icon: CustomIcons.award_1, text: 'Achievements'),
                          DrawerItem(icon: CustomIcons.tags, text: 'Recommendations'),
                          Divider(height: 24, color: Colors.white.withOpacity(0.15)),
                          DividerSectionHeader(text: 'Manga'),
                          DrawerItem(icon: CustomIcons.book, text: 'Manga List'),
                          DrawerItem(icon: CustomIcons.award, text: 'Top Manga'),
                          DrawerItem(icon: CustomIcons.history_1, text: 'History'),
                          DrawerItem(icon: CustomIcons.book_reader, text: 'Achievements'),
                          DrawerItem(icon: CustomIcons.tag_empty, text: 'Recommendations'),
                          Divider(height: 24, color: Colors.white.withOpacity(0.15)),
                          DividerSectionHeader(text: 'More'),
                          DrawerItem(icon: CustomIcons.user_outline, text: 'My Profile'),
                          DrawerItem(icon: CustomIcons.wrench, text: 'Settings'),
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
