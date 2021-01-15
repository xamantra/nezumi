import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../components/app-settings/index.dart';
import '../../../mixins/index.dart';
import '../../index.dart';

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
                      // TODO: extract widget as "SettingItem" with appropriate parameters.
                      Ripple(
                        onPressed: () {
                          appSettings.controller.changeCompactModeState(!appSettings.compactMode);
                        },
                        radius: 0,
                        padding: sy(8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Compact List Mode',
                                    style: TextStyle(
                                      fontSize: sy(11),
                                      color: AppTheme.of(context).text1,
                                    ),
                                  ),
                                  SizedBox(height: sy(4)),
                                  Text(
                                    'Smaller cover image, Smaller vertical padding and only two lines of text each item instead of three.',
                                    style: TextStyle(
                                      fontSize: sy(9),
                                      color: AppTheme.of(context).text4,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Checkbox(
                              value: appSettings.compactMode,
                              activeColor: AppTheme.of(context).primary,
                              onChanged: (compactMode) {
                                appSettings.controller.changeCompactModeState(compactMode);
                              },
                            ),
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
      },
    );
  }
}
