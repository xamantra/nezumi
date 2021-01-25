import 'package:meta/meta.dart';
import 'package:momentum/momentum.dart';

import '../../data/types/index.dart';
import 'index.dart';

class SettingsController extends MomentumController<SettingsModel> {
  @override
  SettingsModel init() {
    return SettingsModel(
      this,
      requiredMinsPerEp: 23,
      requiredEpsPerDay: 4,
      compactMode: false,
    );
  }

  @override
  void bootstrap() {
    initializeAnimeListFields();
  }

  void initializeAnimeListFields({bool reset = false}) {
    var current = model.selectedAnimeListFields;
    if (current == null || current.isEmpty || reset) {
      Map<AnimeListField, bool> selectedAnimeListFields = {};
      for (var field in AnimeListField.values) {
        switch (field) {
          case AnimeListField.title:
            selectedAnimeListFields.putIfAbsent(AnimeListField.title, () => true);
            break;
          case AnimeListField.format:
            selectedAnimeListFields.putIfAbsent(AnimeListField.format, () => true);
            break;
          case AnimeListField.season:
            selectedAnimeListFields.putIfAbsent(AnimeListField.season, () => true);
            break;
          case AnimeListField.airingStatus:
            selectedAnimeListFields.putIfAbsent(AnimeListField.airingStatus, () => true);
            break;
          case AnimeListField.listStatus:
            selectedAnimeListFields.putIfAbsent(AnimeListField.listStatus, () => false);
            break;
          case AnimeListField.episodes:
            selectedAnimeListFields.putIfAbsent(AnimeListField.episodes, () => true);
            break;
          case AnimeListField.durationPerEpisode:
            selectedAnimeListFields.putIfAbsent(AnimeListField.durationPerEpisode, () => true);
            break;
          case AnimeListField.totalDuration:
            selectedAnimeListFields.putIfAbsent(AnimeListField.totalDuration, () => false);
            break;
          case AnimeListField.sourceMaterial:
            selectedAnimeListFields.putIfAbsent(AnimeListField.sourceMaterial, () => true);
            break;
          case AnimeListField.studios:
            selectedAnimeListFields.putIfAbsent(AnimeListField.studios, () => false);
            break;
          case AnimeListField.ageRating:
            selectedAnimeListFields.putIfAbsent(AnimeListField.ageRating, () => false);
            break;
        }
      }
      model.update(selectedAnimeListFields: selectedAnimeListFields);
    }
  }

  void updateAnimeField({
    @required AnimeListField field,
    @required bool value,
  }) {
    if (field == AnimeListField.title) {
      sendEvent(SettingsWarning('Cannot hide title.'));
      return;
    }
    var selectedAnimeListFields = Map<AnimeListField, bool>.from(model.selectedAnimeListFields);
    selectedAnimeListFields[field] = value;
    model.update(selectedAnimeListFields: selectedAnimeListFields);
  }

  void toggleAnimeField(AnimeListField field) {
    if (field == AnimeListField.title) {
      sendEvent(SettingsWarning('Cannot hide title.'));
      return;
    }
    var selectedAnimeListFields = Map<AnimeListField, bool>.from(model.selectedAnimeListFields);
    selectedAnimeListFields[field] = !selectedAnimeListFields[field];

    var currentlyChecked = model.getSelectedAnimeFields.length;
    if (currentlyChecked >= 7 && selectedAnimeListFields[field]) {
      sendEvent(SettingsError('Can only show up to 6 fields in anime list item aside from the title.'));
      return;
    }

    model.update(selectedAnimeListFields: selectedAnimeListFields);
  }

  void reorderFields(int oldIndex, int newIndex) {
    var titleMoved = oldIndex == 0 && newIndex != 0;
    var titleAffected = newIndex == 0 && oldIndex != 0;
    if (titleMoved || titleAffected) {
      sendEvent(SettingsWarning('Cannot re-order the title.'));
      return;
    }
    var fields = model.selectedAnimeListFields?.keys?.toList() ?? [];
    var field = fields[oldIndex];
    var index = fields.indexWhere((x) => x == field);
    fields.removeAt(index);
    if (oldIndex < newIndex) {
      fields.insert(newIndex - 1, field);
    } else {
      fields.insert(newIndex, field);
    }
    var oldMap = model.selectedAnimeListFields ?? {};
    Map<AnimeListField, bool> selectedAnimeListFields = {};
    for (var i = 0; i < fields.length; i++) {
      var value = oldMap[fields[i]];
      selectedAnimeListFields.putIfAbsent(fields[i], () => value);
    }
    model.update(selectedAnimeListFields: selectedAnimeListFields);
  }

  void changeCompactModeState(bool compactMode) {
    model.update(compactMode: compactMode ?? false);
  }
}
