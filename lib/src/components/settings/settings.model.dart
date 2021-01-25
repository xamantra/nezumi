import 'package:momentum/momentum.dart';

import '../../data/types/index.dart';
import 'index.dart';

class SettingsModel extends MomentumModel<SettingsController> {
  SettingsModel(
    SettingsController controller, {
    this.requiredMinsPerEp,
    this.requiredEpsPerDay,
    this.selectedAnimeListFields,
    this.compactMode,
    this.listMode,
  }) : super(controller);

  final int requiredMinsPerEp;
  final int requiredEpsPerDay;
  final bool compactMode;
  final bool listMode;

  final Map<AnimeListField, bool> selectedAnimeListFields;
  List<AnimeListField> get getSelectedAnimeFields {
    var result = <AnimeListField>[];
    selectedAnimeListFields?.forEach((key, value) {
      if (value) {
        result.add(key);
      }
    });
    return result;
  }

  double get requiredHoursPerDay => double.parse(((requiredMinsPerEp * requiredEpsPerDay) / 60).toStringAsFixed(2));

  @override
  void update({
    int requiredMinsPerEp,
    int requiredEpsPerDay,
    Map<AnimeListField, bool> selectedAnimeListFields,
    bool compactMode,
    bool listMode,
  }) {
    SettingsModel(
      controller,
      requiredMinsPerEp: requiredMinsPerEp ?? this.requiredMinsPerEp,
      requiredEpsPerDay: requiredEpsPerDay ?? this.requiredEpsPerDay,
      selectedAnimeListFields: selectedAnimeListFields ?? this.selectedAnimeListFields,
      compactMode: compactMode ?? this.compactMode,
      listMode: listMode ?? this.listMode,
    ).updateMomentum();
  }

  Map<String, dynamic> toJson() {
    Map<String, bool> _jsonAnimeFields = {};
    selectedAnimeListFields?.forEach((key, value) {
      _jsonAnimeFields.putIfAbsent(animeListField_toJson(key), () => value);
    });
    return {
      'requiredMinsPerEp': requiredMinsPerEp,
      'requiredEpsPerDay': requiredEpsPerDay,
      'compactMode': compactMode,
      'listMode': listMode,
      'selectedAnimeListFields': _jsonAnimeFields,
    };
  }

  SettingsModel fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    Map<AnimeListField, bool> _parsedAnimeFields = {};
    Map<String, dynamic> source = json['selectedAnimeListFields'] ?? {};
    source.forEach((key, value) {
      _parsedAnimeFields.putIfAbsent(animeListField_fromJson(key), () => value);
    });

    return SettingsModel(
      controller,
      requiredMinsPerEp: json['requiredMinsPerEp'] ?? 23,
      requiredEpsPerDay: json['requiredEpsPerDay'] ?? 4,
      compactMode: json['compactMode'] ?? false,
      listMode: json['listMode'] ?? true,
      selectedAnimeListFields: _parsedAnimeFields,
    );
  }
}
