import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../components/app-settings/index.dart';
import '../../../mixins/index.dart';
import '../../index.dart';
import 'widgets/index.dart';
import 'widgets/items/index.dart';

class AppSettingsPage extends StatefulWidget {
  const AppSettingsPage({Key key}) : super(key: key);

  @override
  _AppSettingsPageState createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends State<AppSettingsPage> with CoreStateMixin {
  @override
  Widget build(BuildContext context) {
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BoolSettingItem(
                        value: appSettings.compactMode,
                        onChanged: (compactMode) {
                          appSettings.controller.changeCompactModeState(compactMode);
                        },
                        title: 'Compact List Mode',
                        description: 'Smaller cover image, smaller vertical padding and only up to 3 anime fields is displayed aside from the entry title.',
                      ),
                      DialogSettingItem(
                        title: 'Anime List Fields',
                        description: 'Select specific anime info to show in each item from the list. Drag and drop to re-order. And can only show up to 6 fields aside from the title.',
                        builder: (_) => AnimeListFieldsDialogSetting(),
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
