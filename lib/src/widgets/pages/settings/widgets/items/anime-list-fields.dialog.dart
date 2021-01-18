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

class _AnimeListFieldsDialogSettingState extends State<AnimeListFieldsDialogSetting> with CoreStateMixin {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: RelativeBuilder(
        builder: (context, height, width, sy, sx) {
          return Container(
            width: width,
            decoration: BoxDecoration(
              color: AppTheme.of(context).primaryBackground,
              borderRadius: BorderRadius.circular(5),
            ),
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
                      if (oldIndex == 0 && newIndex != 0) {
                        showWarning('Cannot re-order the title.');
                      } else {
                        settings.controller.reorderFields(oldIndex, newIndex);
                      }
                    },
                    separator: Divider(height: 1, color: AppTheme.of(context).text8),
                  );
                }),
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
                if (field == AnimeListField.title) {
                  showWarning('Cannot hide title.');
                }
              },
            ),
            onTap: () {
              settings.controller.toggleAnimeField(field);
              if (field == AnimeListField.title) {
                showWarning('Cannot hide title.');
              }
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
}
