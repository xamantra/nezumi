import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../components/app-settings/index.dart';
import '../../../mixins/index.dart';
import '../../index.dart';
import 'widgets/index.dart';

class AppSettingsPage extends StatefulWidget {
  const AppSettingsPage({Key key}) : super(key: key);

  @override
  _AppSettingsPageState createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends State<AppSettingsPage> with CoreStateMixin {
  @override
  Widget build(BuildContext context) {
    // TODO: add "Anime List Item Fields" setting that allows user to select which anime fields they want to get displayed in all anime listing page (media-type, airing-status, list-status, episodes, etc...)
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return MomentumBuilder(
          controllers: [AppSettingsController],
          builder: (context, snapshot) {
            return Scaffold(
              backgroundColor: AppTheme.of(context).primary,
              appBar: Toolbar(
                height: sy(36),
                leadingIcon: Icons.menu,
                title: 'App Settings',
                actions: [],
                leadingAction: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
              body: SafeArea(
                child: Container(
                  height: height,
                  width: width,
                  color: AppTheme.of(context).primaryBackground,
                  child: Column(
                    children: [
                      BoolSettingItem(
                        value: appSettings.compactMode,
                        onChanged: (compactMode) {
                          appSettings.controller.changeCompactModeState(compactMode);
                        },
                        title: 'Compact List Mode',
                        description: 'Smaller cover image, Smaller vertical padding and only two lines of text each item instead of three.',
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
