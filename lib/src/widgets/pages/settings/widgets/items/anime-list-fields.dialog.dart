import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../../../components/settings/index.dart';
import '../../../../../data/types/index.dart';
import '../../../../../mixins/index.dart';
import '../../../../../utils/index.dart';
import '../../../../index.dart';

class AnimeListFieldsDialogSetting extends StatefulWidget {
  const AnimeListFieldsDialogSetting({Key key}) : super(key: key);

  @override
  _AnimeListFieldsDialogSettingState createState() => _AnimeListFieldsDialogSettingState();
}

class _AnimeListFieldsDialogSettingState extends MomentumState<AnimeListFieldsDialogSetting> with CoreStateMixin {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    settings.controller.listen<SettingsWarning>(
      state: this,
      invoke: (event) {
        showWarning(event.message);
      },
    );
    settings.controller.listen<SettingsError>(
      state: this,
      invoke: (event) {
        showError(event.message);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: RelativeBuilder(
        builder: (context, height, width, sy, sx) {
          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: AppTheme.of(context).primaryBackground,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: sy(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Choose anime info',
                        style: TextStyle(
                          fontSize: sy(12),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      SizedButton(
                        height: sy(32),
                        width: sy(40),
                        radius: 5,
                        child: Text(
                          'Reset',
                          style: TextStyle(
                            fontSize: sy(10),
                            fontWeight: FontWeight.w400,
                            color: Colors.redAccent,
                          ),
                        ),
                        onPressed: () {
                          settings.controller.resetAnimeFields();
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: MomentumBuilder(
                      controllers: [SettingsController],
                      builder: (context, snapshot) {
                        var items = <Widget>[];
                        settings.selectedAnimeListFields.forEach((key, value) {
                          items.add(buildItem(field: key, value: value));
                        });
                        return ReorderableSeparator(
                          children: items,
                          onReorder: (oldIndex, newIndex) {
                            print([oldIndex, newIndex]);
                            settings.controller.reorderFields(oldIndex, newIndex);
                          },
                          separator: Divider(height: 1, color: AppTheme.of(context).text8),
                        );
                      }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildItem({
    @required AnimeListField field,
    @required bool value,
  }) {
    return RelativeBuilder(
      key: Key('buildItem(${field.toString()})'),
      builder: (context, height, width, sy, sx) {
        return InkWell(
          onTap: () {},
          child: ListTile(
            title: Text(
              animeListField_toJson(field),
              style: TextStyle(
                fontSize: sy(10),
              ),
              textAlign: TextAlign.start,
            ),
            trailing: Checkbox(
              value: value,
              activeColor: AppTheme.of(context).primary,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: (value) {
                settings.controller.updateAnimeField(field: field, value: value);
              },
            ),
            onTap: () {
              settings.controller.toggleAnimeField(field);
            },
          ),
        );
      },
    );
  }

  void showWarning(String message) {
    showToast(
      message,
      fontSize: 14,
      color: Colors.orange,
    );
  }

  void showError(String message) {
    showToast(
      message,
      fontSize: 14,
      color: Colors.redAccent,
    );
  }
}
